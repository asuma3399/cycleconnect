class PostsController < ApplicationController
  before_action :authenticate_user!
  require 'exifr/jpeg'

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def search
    if params[:keyword].blank?
      redirect_to posts_path and return
    end
  
    @posts = Post.where('description LIKE ?', "%#{params[:keyword]}%").order("created_at DESC")
    render :search
  end

  def new
    @post_form = PostForm.new
  end

  def create
    @post_form = PostForm.new(post_form_params)
    @post_form.user_id = current_user.id

    if params[:post_form][:image].present? && params[:post_form][:image].content_type == 'image/jpeg'
      exif = EXIFR::JPEG.new(params[:post_form][:image].tempfile)
      if exif && exif.gps
        @post_form.latitude = exif.gps.latitude
        @post_form.longitude = exif.gps.longitude
      end
    end

    if @post_form.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    @post_form = PostForm.new(post.attributes)
    post.destroy
    redirect_to posts_path
  end

  private

  def post_form_params
    params.require(:post_form).permit(:description, :garmin_url, :tag_name, :image, :latitude, :longitude)
  end
end
