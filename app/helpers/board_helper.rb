module BoardHelper

  # Give the name of signed user  
  def signed_name
    if has_user_signed?
      User.find_by_id(session[:user_id]).name
    else
      "buddy"
    end
  end
end
