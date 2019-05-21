class SessionsController < ApplicationController
  before_action :redirect_user, only: [:new, :create]

  def new
    user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      self.login_user!
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
