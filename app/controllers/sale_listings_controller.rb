class SaleListingsController < ApplicationController

  before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @listing = SaleListing.new(listing_params)
    if @listing.save
      redirect_to @listing
    else
      flash[:errors] = @listing.errors.full_messages
      redirect_to :back
    end
  end

  def show
  end

private
  def listing_params
    params.require(:listing).permit(:address, :street, :unit, :city, :state, :zip)
  end
  
end
