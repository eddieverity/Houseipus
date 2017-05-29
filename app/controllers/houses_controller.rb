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

    require 'net/http'
    require 'json'

    def maptest
        @url = 'https://maps.googleapis.com/maps/api/geocode/json?address=60640&sensor=false'
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @data = JSON.parse(@response)

        @lat = @data['results'][0]['geometry']['location']['lat']
        @lng = @data['results'][0]['geometry']['location']['lng']

        puts @latlong
    end
    

end
