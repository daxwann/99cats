class CatRentalRequestsController < ApplicationController
  def index
    render json: CatRentalRequest.find_by(cat_id: params[:id])
  end
  
  def new
  end

  def create
  end
  
  def edit
  end

  def update
  end

  def destroy
  end

  private

  def request_params
    params.require(:request).permit(:cat_id, :start_id, :end_id, :status)
  end
end
