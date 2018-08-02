class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to user, notice: 'Account avtivated!'
    else
      redirect_to root_path, notice: 'Invalid activation link'
    end
  end
end
