class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    User.find_by(session_token: session[:session_token])
  end

  def login_user!
    token = @user.reset_session_token!
    session[:session_token] = token
  end

  def redirect_user
    if current_user
      redirect_to cats_url
    end
  end
end
