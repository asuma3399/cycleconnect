class LikesController < ApplicationController
  before_action :set_post

  def create
    like = current_user.likes.build(post_id: params[:post_id])
    like.save
    render partial: 'likes/like', locals: { post: @post }
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    render partial: 'likes/like', locals: { post: @post }
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
  