class SessionsController < ApplicationController
  before_filter :authorize

  def authorize
    if session[:user_id]
      redirect_to admin_url
    end
  end

  def new
  end

  def create
    if !(user = User.find_by_name(params[:name]))
      alert = "User doesn't exist"
    elsif !user.authenticate(params[:password])
      alert = "Password is invalid"
    end

    unless alert
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => alert
    end
  end

  def destroy
    session[:user_id] = nil
  end
end
