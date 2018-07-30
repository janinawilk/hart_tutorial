class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :destroy, :update]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, notice: 'User was created'
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was updated'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = 'Please log in'
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    store_location
    # flash[:danger] = "Please log in."
    redirect_to login_path unless current_user?(@user)
  end
end
