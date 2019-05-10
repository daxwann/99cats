class CatsController < ApplicationController
  def index
    render :index
  end

  def show
    render json: Cat.find_by(id: params[:id]) 
  end
end
