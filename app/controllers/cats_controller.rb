class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @kitty = Cat.find_by(id: params[:id])
    render :show 
  end

  def new
    render :new
  end

  def edit
    @kitty = Cat.find_by(id: params[:id])
    render :edit
  end
end
