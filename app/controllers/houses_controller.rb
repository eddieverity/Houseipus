class HousesController < ApplicationController

    def routes
        @location = params[:location]
        if params[:searchtype] == 'sell'
            redirect_to "/houses/house_sell/#{params[:location]}"
        elsif params[:searchtype] == 'buy'
            redirect_to "/houses/house_buy/#{params[:location]}"
        elsif params[:searchtype] == 'rent'
            redirect_to "/houses/house_rent#{params[:location]}"
        end
    end

    def house_sell
        @listing = Geocoder.search(params[:location]).first
        @short_name = @listing.data['address_components'][0]['short_name']
        @states = ["AK", "AL","AR","AS","AZ","CA","CO","CT","DC","DE","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
        if @states.include? @short_name
            @zoom = 6
        elsif (@listing.data['address_components'][0]['types'] & ["neighborhood", "postal_code"]).present?
            @zoom = 13
        else
            @zoom = 10
        end
        @lat = @listing.data['geometry']['location']['lat']
        @lng = @listing.data['geometry']['location']['lng']
    end

    def house_buy
        @listing = Geocoder.search(params[:location]).first
        @short_name = @listing.data['address_components'][0]['short_name']
        @states = ["AK", "AL","AR","AS","AZ","CA","CO","CT","DC","DE","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
        if @states.include? @short_name
            @zoom = 6
        elsif (@listing.data['address_components'][0]['types'] & ["neighborhood", "postal_code"]).present?
            @zoom = 13
        else
            @zoom = 10
        end
        @lat = @listing.data['geometry']['location']['lat']
        @lng = @listing.data['geometry']['location']['lng']
    end
    

    def house_rent
        @listing = Geocoder.search(params[:location]).first
        @short_name = @listing.data['address_components'][0]['short_name']
        @states = ["AK", "AL","AR","AS","AZ","CA","CO","CT","DC","DE","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
        if @states.include? @short_name
            @zoom = 6
       elsif (@listing.data['address_components'][0]['types'] & ["neighborhood", "postal_code"]).present?
            @zoom = 13
        else
            @zoom = 10
        end
        @lat = @listing.data['geometry']['location']['lat']
        @lng = @listing.data['geometry']['location']['lng']
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
