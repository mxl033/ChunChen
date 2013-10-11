class SignupController < ApplicationController
  before_filter :has_signed_in

  def has_signed_in
    if session[:user_id]
      redirect_to root_url
    end
  end

  # GET /signup/new
  def new
    @user = User.new
  end

  # POST /signup
  def create
    @user = User.new(input_params)

    if @user.save
      # Recode user id in session
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'User was successfully created'
    else
      render :new
    end
  end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def input_params
    params.require(:signup).permit(:name, :email, :password, :password_confirmation)
  end
end
