class SessionsController < ApplicationController
  before_action :redirect_user!, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect username and/or password"]
      @user = User.new(
        username: params[:user][:username],
        password: params[:user][:password]
      )
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to cats_url
  end
end
