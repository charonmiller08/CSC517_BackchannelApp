class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:signup, :create]
  before_filter :make_user_login, :except  => [:signup, :create]
  after_filter :store_location

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    if is_admin?
      @users = User.all
    elsif is_member?
      @users = [@current_user]
    else
      redirect_to "signup"
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @post_count = Post.where(:user_id => @user.id).count
    @vote_count = Vote.where(:user_id => @user.id).count
    @vote_for_your_posts_count = Post.where(:user_id => @user.id).joins(:votes).count

    if !is_admin?
      if !(@user == @current_user)
        redirect_to @current_user
        return
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def signup
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  # GET /users/new
  # GET /users/new.json
  def new
    if is_admin?
      if @superadmin_user
        @role_options = ["Administrator", "Member"]
      else
      @role_options = ["Member"]
      end
    else
      redirect_back_or(home_url)
      return
    end



    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @role_options = ["Member"]
    if is_admin?
      if @superadmin_user
        @role_options = ["Administrator", "Member"] ;
      end

    else
      @user = @current_user
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if !is_admin?
      @user.role = "Member"
    end
    respond_to do |format|
      if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.'}
          format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render "signup"}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    if is_admin?
       if @user.role == "Super Administrator"
         flash[:notice] = "The Super Administrator cannot be deleted"
         redirect_to @user
         return
       end
       if @user.role == "Administrator"
         if !@superadmin_user
         if !(@current_user == @user)
           flash[:notice] = "Only the super administrator can delete other administrators"
           redirect_to @user
           return
         end
         end
       end
    else
      if !(@current_user == @user)
        flash[:notice] = "You do not have permission to delete this user!"
        redirect_to @current_user
        return
      end
    end
    @posts = Post.where(:user_id => @user.id).all
    @replies = Reply.where(:user_id => @user.id).all
    @anonymous = User.where(:username => 'Anonymous').first
    @posts.each do |p|
    p.update_attributes(:user_id => @anonymous.id)
    end
    @replies.each do |r|
      r.update_attributes(:user_id => @anonymous.id)
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
