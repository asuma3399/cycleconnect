class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to profile_path(current_user) unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user && @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :icon, :bio)
  end
end
