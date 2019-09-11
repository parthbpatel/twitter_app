class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      #flash message for account activation
      flash[:success] = "Account activated!"
      redirect_to user
    else
      #flash message for invalid link
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
