class PostsController < ApplicationController
  before_filter :make_user_login, :only => [:new, :create, :edit, :destroy, :update]
  before_filter :logged_in? #, :only => [:index, :new, :create,:edit, :destroy, :update]
  after_filter :store_location

  # GET /posts
  # GET /posts.json
  def vote
    puts "trying votes againsss"
    @votes_existing = Vote.find_all_by_post_id_and_user_id(params[:post_id],params[:user_id])


    if !@votes_existing
      @vote = Vote.new()
      @vote.post_id = params[:post_id]
      @vote.user_id = params[:user_id]
    else
      redirect_back_or(home_url)

      return
    end


    respond_to do |format|
      if @vote.save
        format.html { redirect_back_or(home_url)}
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
  def index
    @number_of_votes = Hash.new
    @posts = Post.search(params[:name], params[:search])
    @posts.each do |p|
    @number_of_votes[p] = Vote.where(:post_id => p.id).count
    end

    #if params[:search]
      #@category_id = Category.where('name LIKE ?', '%#(params[:search])%').all
    #  @posts = Post.where('content LIKE ?', "%#{params[:search]}%").all
    #end
   # search_class = params[:search_class]
   # search_string = params[:search_string]
    #if(search_string != nil)
    #  if(search_class == Tag || search_class == Content)
    #    @posts = Post.where('content LIKE ?', '%'+search_string+'%').all
    #  end
   # end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    array_of_primary_key = []
    @post_replies = Reply.where(:parent_post_id => @post.id).all
    puts "WHAT DOES THIS LOOK LIKE?"
    puts @post_replies

    @replies = []
    @post_replies.each do |p|
      @replies << Post.find_by_id(p.post_id)
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
    @created = @post
    if params[:parent_post_id]
      @reply = Reply.new()
      @reply.parent_post_id = params[:parent_post_id]
      @reply.post_id = @post.id
      @created = @reply
      @post = Post.where(:id => @reply.parent_post_id).first

    end

    respond_to do |format|
      if @created.save
        format.html { redirect_to @post, notice: 'Thank you for posting!' }
        format.json { render json: @post, status: :created, location: @post }
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
