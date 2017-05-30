class HousesController < ApplicationController
    #the next two lines are only required currently for the maptest method
    require 'net/http'
    require 'json' 


    def routes
        @location = params[:location]
        if params[:searchtype] == 'sell'
            redirect_to "/houses/house_sell/#{params[:location]}"
        elsif params[:searchtype] == 'buy'
            redirect_to "/houses/house_buy/#{params[:location]}"
        elsif params[:searchtype] == 'rent'
            redirect_to "/houses/house_rent/#{params[:location]}"
        end
    end


    def house_sell
        locator(params[:location])

        @url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{@lat},#{@lng}&key=AIzaSyDEIuPwq4UmLFZ-zqDXmqP1NI54lJhXllY"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @data = JSON.parse(@response)

        @addressform = @data['results'][0]['address_components']
    end

    def house_buy
        locator(params[:location])

        @listings = SaleListing.within(10, :origin => params[:location])

        @alllistings = @listings.to_json

    end
    

    def house_rent
        locator(params[:location])
    end
    
    def sell
        @newlisting = SaleListing.new(listing_params)
        if @newlisting.save
            redirect_to '/'
        else
            flash[:errors] = @newlisting.errors.fullmessages
            redirect_back(fallback_location: 'houses/house_sell/')
        end
    end

    def show_sl
        @listing = SaleListing.find(params[:sale_id])
    end

    def maptest
        @url = 'https://maps.googleapis.com/maps/api/geocode/json?address=60640&sensor=false'
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @data = JSON.parse(@response)

        @lat = @data['results'][0]['geometry']['location']['lat']
        @lng = @data['results'][0]['geometry']['location']['lng']

        puts @latlong
    end

private

    def listing_params
        params.require(:listing).permit(:address, :street, :unit, :city, :state, :zip, :user_id, :latitude, :longitude)
    end
    

    #searches gmaps based on user input from form on homepage; used in BUY, SELL, and RENT pages
    def locator location
        @listing = Geocoder.search(location).first
        @short_name = @listing.data['address_components'][0]['short_name']
        puts @listing.data['address_components'][0]['types'].inspect
        @states = ["AK", "AL","AR","AS","AZ","CA","CO","CT","DC","DE","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
        if @states.include? @short_name
            @zoom = 6
        elsif (@listing.data['address_components'][0]['types'] & ["neighborhood", "postal_code"]).present?
            @zoom = 13
        elsif @listing.data['address_components'][0]['types'].include? "street_number"
            @zoom = 16 
        else
            @zoom = 10
        end
        @lat = @listing.data['geometry']['location']['lat']
        @lng = @listing.data['geometry']['location']['lng']
    end 
    
end
