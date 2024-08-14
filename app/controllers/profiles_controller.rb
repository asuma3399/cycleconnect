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
  
    original_username = @user.username
    original_email = @user.email
  
    Rails.logger.debug("Updating user with params: #{user_params.inspect}")
  
    if @user.update(user_params)
      @user.update_columns(username: original_username, email: original_email)
      redirect_to profile_path, notice: 'プロフィールが更新されました。'
    else
      Rails.logger.debug("Errors: #{@user.errors.full_messages.join(", ")}")
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:bio, :icon)
  end
end