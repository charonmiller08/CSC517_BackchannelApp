class RepliesController < ApplicationController
  before_filter :make_user_login, :only => [:new, :create, :edit, :destroy, :update]
  before_filter :logged_in?
  after_filter :store_location
  # GET /replies
  # GET /replies.json
  def index
    redirect_to posts_url
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    @reply = Reply.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.json
  def new
    @post_id = params[:reply][:post_id]
    #@post_id = params[:post_id]
    @parent_post_id= params[:reply][:parent_post_id]
    #@parent_post_id= params[:parent_post_id]
    @reply = Reply.new()
    create
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(params[:reply])
    @reply.parent_post_id = params[:reply][:parent_post_id]
    @reply.post_id = params[:reply][:post_id]
    @post = Post.where(:id => @reply.parent_post_id).first


    respond_to do |format|
      if @reply.save
        format.html { redirect_to @post, notice: 'Reply was successfully created.' }
        format.json { render json: @reply, status: :created, location: @reply }
      else
        format.html { render action: "new" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    @reply = Reply.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])
    @post_id = @reply.post_id
    @reply.destroy
    @post = Post.find(@post_id)
    @post.destroy

    respond_to do |format|
      format.html { redirect_back_or(posts_url)}
      format.json { head :no_content }
    end
  end
end
