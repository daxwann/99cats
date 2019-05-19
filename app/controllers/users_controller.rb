class UsersController < ApplicationController
  before_action :redirect_user 

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      self.login_user!
      redirect_to cats_url
    else
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
