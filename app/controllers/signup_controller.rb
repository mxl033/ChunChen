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

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def input_params
    params.require(:signup).permit(:name, :password, :password_confirmation)
  end
end
