class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # PROBABLY NOT NEEDED
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # PUBLIC PROFILE PAGE
  # GET /users/1
  # GET /users/1.json
  def show
    @post = Post.new
    @relationship = Relationship.where(
      follower_id: current_user.id,
      followed_id: @user.id
    ).first_or_initialize if current_user
  end

  def show_favorites
  end

  # SIGNUP PAGE
  # GET /users/new
  def new
    if current_user
      redirect_to home_path
    else
      @user = User.new
    end
  end

  # SETTINGS EDIT PAGE
  # GET /users/1/edit
  def edit
  end

  # GET LIST OF POSTS OF FOLLOWED USERS
  #
  def profile
    if current_user
      @post = Post.new
      friend_ids = current_user.followeds.map(&:id).push(current_user.id)
      @posts = Post.find_all_by_user_id(friend_ids)
    else
      redirect_to root_url
    end
  end

  # POST SIGNUP
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'Account registered!' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # SETTINGS UPDATE
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE USER
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :name, :password, :password_confirmation, :email)
    end
end
