class PostsController < ApplicationController
  before_filter :make_user_login, :only => [:new, :create, :edit, :destroy, :update]
  before_filter :logged_in? #, :only => [:index, :new, :create,:edit, :destroy, :update]
  after_filter :store_location

  # GET /posts
  # GET /posts.json
  def index
    @number_of_votes = Hash.new
    @sort_by_this = Hash.new
    @posts = Post.search(params[:name], params[:search])
    @posts.each do |p|
      @number_of_votes[p] = Vote.where(:post_id => p.id).count
      @number_of_replies  = Reply.where(:parent_post_id => p.id).count
      if p.updated_at.to_time < (Time.now - 1.minute)
        @time_weight= 5
      elsif p.updated_at.to_time < (Time.now - 1.hour)
        @time_weight = 4
      elsif p.updated_at.to_time < (Time.now - 1.day)
        @time_weight = 3
      elsif p.updated_at.to_time < (Time.now - 1.week)
        @time_weight = 2
      elsif p.updated_at.to_time < (Time.now - 1.month)
        @time_weight = 1
      else
        @time_weight = 0
      end
      @sort_by_this[p.id] = (@number_of_votes[p] + @number_of_replies)*@time_weight
    end
    @sort_by_this.values.sort

    @posts_sorted = Post.where(:id => nil).where("id IS NOT ?", nil)
    @sort_by_this.each do |p|
      @posts_sorted << Post.find(p[0])
    end

    @posts = @posts_sorted

    if !(params[:search] == nil)
      flash.now[:notice] = "You searched by #{params[:name]} with search text \"#{params[:search]}\"."
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @number_of_votes = Vote.where(:post_id => @post.id).count
    array_of_primary_key = []
    @post_replies = Reply.where(:parent_post_id => @post.id).all

      @replies = []
      @number_of_votes_reply = Hash.new
      @post_replies.each do |p|
        @replies << Post.find_by_id(p.post_id)
        @number_of_votes_reply[Post.find_by_id(p.post_id)] = Vote.where(:post_id => p.post_id).count
      end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new_as
  # GET /posts/new_as.json
  def new
    @parent_post_id = params[:parent_post_id]
    @post = Post.new

    respond_to do |format|
      format.html # login.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = @current_user.id

      respond_to do |format|
        if @post.save
          if params[:parent_post_id]
            #@parent_post_id = params[:parent_post_id]
            #@post_id = @post.id
            format.html {redirect_to controller: 'replies', action: 'new' , reply: {parent_post_id: params[:parent_post_id], post_id: @post.id}}
            format.json { render json: @post, status: :created, location: @post }
          else
            format.html { redirect_to @post, notice: 'Thank you for posting!' }
            format.json { render json: @post, status: :created, location: @post }
          end
        else
          format.html { render action: "new" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end


  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        if params[:parent_post_id]
          @parent_post = Post.find(params[:parent_post_id])

          format.html {redirect_to @parent_post, notice: 'Reply was successfully updated.'}
          format.json { head :no_content }
        else
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  # Query posts and votes and calculate the number of votes per post.
  def viewPostsByVotes
    @results = Array.new
    @results = Post.find_by_sql('SELECT title, content, COUNT(post_id) FROM posts INNER JOIN votes ON posts.id = votes.post_id GROUP BY posts.id ORDER BY COUNT(post_id) DESC') #query for getting the number of votes per post
  end

# Query posts and users and calculate the number of posts per user.
  def viewUsersByPosts
    @results = Array.new
    @results = Post.find_by_sql('SELECT username, COUNT(user_id) FROM users INNER JOIN posts ON users.id = posts.user_id GROUP BY users.id ORDER BY COUNT(user_id) DESC') #query for getting the number of posts per user
  end

# Query all posts and find the posts between created between the from_date and to_date datetime parameters.
  def viewPostsByDate
    from_date = params[:from_date] #from_date date parameter set in the runReport view
    to_date = params[:to_date] #to_date date parameter set in the runReport view
    from_date = DateTime.new(from_date["from_date(1i)"].to_i, from_date["from_date(2i)"].to_i, from_date["from_date(3i)"].to_i, from_date["from_date(4i)"].to_i, from_date["from_date(5i)"].to_i) #convert from_date to a datetime object
    to_date = DateTime.new(to_date["to_date(1i)"].to_i, to_date["to_date(2i)"].to_i, to_date["to_date(3i)"].to_i, to_date["to_date(4i)"].to_i, to_date["to_date(5i)"].to_i) #convert to_date to a datetime object
    @results = Array.new
    @results = Post.where(["created_at >= ? AND created_at <= ?", from_date, to_date]) #query for getting posts created between from_date and to_date
  end

#Redirects to a report page based on the report selected to be run in the runReport view.
  def runReport
#Check the value of the report_type parameter and based on its value redirect to a view.
    if params[:report_type] == '1'
      redirect_to usersByPosts_url #Go to the viewUsersByPosts view
    elsif params[:report_type] == '2'
      redirect_to viewByVote_url #Go to the viewPostsByVote view
    elsif params[:report_type] == '3'
      redirect_to(postsByDate_url(:from_date => params[:from_date], :to_date => params[:to_date])) #Go to the viewPostsByDate view

    end
  end
end
