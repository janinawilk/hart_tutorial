class PasswordResetsController < ApplicationController

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_path, notice: 'Email sent with password reset instructions'
    else
      flash.now[:alert] = 'Email address not found'
      render :new
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
    redirect_to root_url unless valid_user?

    if @user.password_reset_expired?
      redirect_to new_password_reset_url, notice: 'Password reset has expired'
    end
  end

  def update
    @user = User.find_by(email: params[:user][:email])
    redirect_to root_url unless valid_user?

    if @user.password_reset_expired?
      redirect_to new_password_reset_url, notice: 'Password reset has expired'
    end

    if params[:user][:password].empty?
      @user.errors.add(:password, 'can\t be empty')
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      redirect_to @user, notice: 'Password has been reset'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_user?
    @user && @user.activated? && @user.authenticated?(:reset, params[:id])
  end
end
