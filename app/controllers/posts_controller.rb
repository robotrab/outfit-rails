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
    # outfit = params[:post].delete(:outfit)
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # @post.outfit = outfit

    if @post.save
      if params[:post][:outfit].blank?
        flash[:notice] = "Post successfully created."
        redirect_to @post
      else
        render action: 'crop'
      end
    else
      flash[:error] = "Problem!"
      render action: 'new'
    end
  end

  # ON POST EDIT
  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if :cropping?
      puts '------------------CROPPING-----------------------'
      @post.outfit.reprocess!
    end
    if @post.update(post_params)
      if params[:post][:outfit].blank?
        flash[:notice] = 'Post was successfully updated.'
        redirect_to @post
      else
        render action: 'crop'
      end
    else
      render action: 'edit'
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

    def cropping?
      !params[:post][:crop_x].blank? && !params[:post][:crop_y].blank? && !params[:post][:crop_w].blank? && !params[:post][:crop_h].blank?
    end
end
