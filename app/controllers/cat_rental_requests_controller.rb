class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    @cats = Cat.all

    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @cats = Cat.all

    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      render :new
    end
  end
=begin
  def edit
    @request = CatRentalRequest.find_by(id: params[:id])
    @cats = Cat.all
    
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
