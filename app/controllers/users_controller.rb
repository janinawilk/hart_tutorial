class UsersController < ApplicationController
  before_action :find_user,       only: [:show, :edit, :destroy, :update]
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_path, notice: 'Please check your email to activate your account'
      # binding.pry
    else
      render :new
    end
  end

  def show
    redirect_to root_path and return unless @user.activated?
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was updated'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User deleted'
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
    unless current_user?(@user)
      flash[:alert] = 'Please log in'
      redirect_to login_path
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
