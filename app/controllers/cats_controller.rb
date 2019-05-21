class CatsController < ApplicationController
  before_action :require_login!, only: [:new, :create, :edit, :update, :destroy]
  before_action :rightful_owner, only: [:edit, :update, :destroy]

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
      flash.now[:errors] = @cat.errors.full_messages
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
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def destroy
    @cat.destroy
    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :description, :birth_date)
  end
end
