class CatRentalRequestsController < ApplicationController
  before_action :rightful_owner, only: [:approve, :deny]

  def new
    @request = CatRentalRequest.new
    @cats = Cat.includes(:requests).all

    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
    @cats = Cat.includes(:requests).all

    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      render :new
    end
  end

  def rightful_owner
    @request = CatRentalRequest.find(params[:id])
    
    unless @request
      redirect_to cats_url
    end

    unless @request.cat.user_id == current_user.id
      redirect_to cat_url(@request.cat_id)
    end
  end

  def approve
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end
=begin
  def edit
    @request = CatRentalRequest.find_by(id: params[:id])
    @cats = Cat.includes(:rental_requests).all
    
    render :edit
  end

  def update
    @request = CatRentalRequest.find_by(id: params[:id]) 
    @cats = Cat.all

    if @request.update_attributes(request_params)
      redirect_to cat_rental_request_url(@request)
    else
      render :edit
    end
  end

  def destroy
    @request = CatRentalRequest.find_by(id: params[:id])

    @request.destroy
    redirect_to cat_url(@request.cat_id)
  end
=end
  private

  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
