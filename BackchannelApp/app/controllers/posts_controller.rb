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
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
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
end
