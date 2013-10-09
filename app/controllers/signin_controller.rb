class SigninController < ApplicationController
  before_filter :has_signed_in, only: [:new, :create]

  def has_signed_in
    if session[:user_id]
      redirect_to root_url
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
      redirect_to root_url
    else
      flash.now[:alert] = alert

      # Clear input password
      params[:password] = nil
      render :new
    end
  end

  def destroy
    unless session[:user_id]
      flash.now[:alert] = "You need to sign in, first"
      render :new
    else
      session[:user_id] = nil
      redirect_to root_url
    end
  end
end
