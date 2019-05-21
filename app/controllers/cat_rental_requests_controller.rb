class CatRentalRequestsController < ApplicationController
  before_action :require_login!, only: [:new, :create, :approve, :deny]
  before_action :rightful_owner, only: [:approve, :deny]

  def new
    @request = CatRentalRequest.new(cat_id: params[:cat_id])
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
      flash.now[:errors] = @request.errors.full_messages
      render :new
    end
  end

  def approve
    current_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_request.deny!
    redirect_to cat_url(current_cat)
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

  def current_request
    @request ||= CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_request.cat
  end

  def rightful_owner
    unless current_user.owns_cat?(current_cat)
      redirect_to cat_url(current_cat)
    end
  end
end
