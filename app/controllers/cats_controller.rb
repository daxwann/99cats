class CatsController < ApplicationController
  before_action :rightful_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])

    if @cat
      render :show 
    else
      redirect_to cats_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end
  
  def rightful_owner
    @cat = current_user.cats.find_by(id: params[:id]) 

    unless @cat
      redirect_to cat_url(params[:id])
    end
  end

  def edit
    render :edit 
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find_by(id: params[:id])

    unless @cat
      redirect_to cats_url
    end

    if @cat.user_id == current_user.id
      @cat.destroy
    else
      redirect_to cat_url(@cat)
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :description, :birth_date)
  end
end
