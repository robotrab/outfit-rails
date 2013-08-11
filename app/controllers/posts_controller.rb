class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :favorite]

  # RENDER POSTS FOR USER
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all include: :user
    @post = Post.new
  end

  # DISPLAY SPECIFIC POST
  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # CREATE NEW POST
  # GET /posts/new
  def new
    @post = Post.new
  end

  # EDIT A POST
  # GET /posts/1/edit
  def edit
  end

  # ON NEW POST CREATE
  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to current_user, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new', error: "Problem!" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # ON POST EDIT
  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE POST
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def favorite
    type = params[:type]
    if type == 'favorite'
      unless current_user.favorites.exists?(@post)
        current_user.favorites << @post
        redirect_to :back, notice: 'You favorited the post.'
      end
    elsif type == 'unfavorite'
      if current_user.favorites.exists?(@post)
        current_user.favorites.delete(@post)
        redirect_to :back, notice: 'Unfavorited post.'
      end
    else
      redirect_to :back, notice: 'Problem favoriting post.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :favorites, :message, :outfit, :crop_x, :crop_y, :crop_w, :crop_h)
    end
end
