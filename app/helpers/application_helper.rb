module ApplicationHelper

  def has_user_signed?
    return (session[:user_id] != nil)
  end
end
