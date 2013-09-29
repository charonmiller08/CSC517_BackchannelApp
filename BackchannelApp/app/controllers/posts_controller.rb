class PostsController < ApplicationController
  before_filter :make_user_login, :only => [:new, :create, :edit, :destroy, :update]
  before_filter :logged_in?, :only => [:index, :new, :create,:edit, :destroy, :update]
  # GET /posts
  # GET /posts.json

  def index
    @posts = Post.search(params[:name], params[:search])
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new_as
  # GET /posts/new_as.json
  def new
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
    # TODO retrieve authenticated user id and add to post
    @post.user_id = @current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
