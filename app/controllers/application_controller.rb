class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  private

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!
    token = @user.reset_session_token!
    session[:session_token] = token
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_user!
    if current_user
      redirect_to cats_url
    end
  end

  def require_login!
    redirect_to new_session_url if current_user.nil?
  end
end
