module ApplicationHelper
  def generate_jwt
    user_signed_in? ? Auth.encode({email: current_user.email}) : nil
  end
end
