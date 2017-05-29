class HousesController < ApplicationController

  def routes
    @location = params[:location]
    if params[:searchtype] == 'sell'
      redirect_to '/houses/house_sell'
    elsif params[:searchtype] == 'buy'
      redirect_to '/houses/house_buy'
    elsif params[:searchtype] == 'rent'
      redirect_to '/houses/house_rent'
    end
  end

  def sell
    render 'house_sell'
  end
end
