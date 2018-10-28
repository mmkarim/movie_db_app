class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def valid_jwt? jwt
    email = Auth.decode(jwt)["email"]
    if user_signed_in? && current_user.email == email
      true
    else
      false
    end
  end
end
