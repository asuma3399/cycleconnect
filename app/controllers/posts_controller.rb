class PostsController < ApplicationController
  before_action :authenticate_user!
  require 'exifr/jpeg'

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:post][:image].present? && params[:post][:image].content_type == 'image/jpeg'
      exif = EXIFR::JPEG.new(params[:post][:image].tempfile)
      if exif && exif.gps
        @post.latitude = exif.gps.latitude
        @post.longitude = exif.gps.longitude
      end
    end

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :latitude, :longitude)
  end
end
