class VotesController < ApplicationController
  before_filter :make_user_login
  before_filter :logged_in?
  after_filter :store_location
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new_as
  # GET /votes/new_as.json
  def new
    @post_id = params[:post_id]
    @vote = Vote.new
    create
    #respond_to do |format|
    #  format.html # login.html.erb
    #  format.json { render json: @vote }
    #end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
    puts "IS THIS WORKING NOWWWW?"

    @previous_votes = Vote.where(:post_id => params[:post_id],:user_id => @current_user.id).all
    if @previous_votes.blank?
      @vote = Vote.new(params[:vote])
      @vote.post_id = params[:post_id]
      @vote.user_id = @current_user.id
    else
      @vote = nil
    end

    respond_to do |format|
      if @vote
        @vote.save
        format.html { redirect_back_or(posts_url, "Thank you for voting!", "valid")}
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html {redirect_back_or(posts_url, "You can't vote for a post more than once!", "invalid")}
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
end
