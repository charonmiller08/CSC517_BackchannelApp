class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:signup, :create]
  before_filter :make_user_login, :only  => [:index, :new, :show, :edit, :destroy, :update]




  # GET /users
  # GET /users.json
  def index
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def signup
    @user = User.new

    respond_to do |format|
      format.html #signup.html.erb
      format.json { render json: @user }
    end
  end
  # GET /users/new_as
  # GET /users/new_as.json
  def new
    @user = User.new

    respond_to do |format|
      format.html #new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    #@user.role = "Member"
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to home_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        if @admin_user
          format.html { render action: "new" }
        else
          format.html { render action: "signup" }
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    #render "new_as"
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
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
