class HousesController < ApplicationController

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
