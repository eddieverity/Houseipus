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

        @listings = SaleListing.joins(:image).within(10, :origin => params[:location])

        @alllistings = @listings.to_json(:include => :image)

    end
    

    def house_rent
        locator(params[:location])
        @listings = RentalListing.all#.within(10, :origin => params[:location])
        #
        #.joins(:rentalimage)
        puts '########'
        puts @listings.inspect
        puts '########'
        @alllistings = @listings.to_json#(:include => :rental_image)
        puts '@@@@@@@'
        puts @alllistings.inspect
        puts '@@@@@@@'
        render ('houses/house_rent.html.erb')
    end
    
    def sell
        # puts '######'
        # puts params[:listing][:rent_sell]
        # puts '######'

        if params[:formchecker] == 'sale'

            @newlisting = SaleListing.new(listing_params)
            if @newlisting.save
                redirect_to "/listings/sale/#{@newlisting.id}/edit"
            else
                flash[:errors] = @newlisting.errors.full_messages
                redirect_back(fallback_location: 'houses/house_sell/')
            end
        else

            @newlisting = RentalListing.new(listing_params)
            if @newlisting.save
                redirect_to "/listings/rent/#{@newlisting.id}/edit"
            else
                flash[:errors] = @newlisting.errors.full_messages
                redirect_back(fallback_location: 'houses/house_sell/')
            end
        end
    end

    def show_sl
        @listing = SaleListing.find(params[:sale_id])
        @images = Image.find_by(sale_listing_id: params[:sale_id])
    end

    def rentalshow
        @listing = RentalListing.find(params[:rental_id])
        @images = RentalImage.find_by(rental_listing_id: params[:rental_id])
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

    def edit
        @listing = SaleListing.find(params[:sale_id])
    end

    def rentaledit
        @listing = RentalListing.find(params[:rental_id])
    end


    def update
        @listing = SaleListing.find(params[:sale_id])

        if @listing.update(listing_data)
            redirect_to "/listings/sale/#{params[:sale_id]}"
        else 
            flash[:errors] = @listing.errors.full_messages
            redirect_to "/listings/sale/#{params[:sale_id]}/edit"
        end
    end

    def rentalupdate
        @listing = RentalListing.find(params[:rental_id])

        if @listing.update(listing_data)
            redirect_to "/listings/rent/#{params[:rental_id]}"
        else 
            flash[:errors] = @listing.errors.full_messages
            redirect_to "/listings/rent/#{params[:rental_id]}/edit"
        end
    end

    # add photos to For Sale listing

    def photos
        @listing = SaleListing.find(params[:sale_id])

        @images = Image.new
    end

    def addphotos
        @images = Image.find_by(sale_listing_id: params[:sale_id])

        if @images
            if @images.update(image_params)
                redirect_to "/listings/sale/#{params[:sale_id]}"
            else
                flash[:errors] = @images.errors.full_messages
                redirect_to "/listings/sale/#{params[:sale_id]}/photos"
            end
        else
            @images = Image.new(image_params)
            if @images.save
                redirect_to "/listings/sale/#{params[:sale_id]}"
            else
                flash[:errors] = @images.errors.full_messages
                redirect_to "/listings/sale/#{params[:sale_id]}/photos"
            end
        end
    end

    # add photos to Rental Listing
    def rentalphotos
        @listing = RentalListing.find(params[:rental_id])

        @images = RentalImage.new
    end
    
    def addrentalphotos
        @images = RentalImage.find_by(rental_listing_id: params[:rental_id])

        if @images

            if @images.update(image_params)
                redirect_to "/listings/rent/#{params[:rental_id]}"

            else
                flash[:errors] = @images.errors.full_messages
                redirect_to "/listings/rent/#{params[:rental_id]}/photos"
            end
        else
            @images = RentalImage.new(rental_image_params)
            if @images.save
                redirect_to "/listings/rent/#{params[:rental_id]}"
            else
                flash[:errors] = @images.errors.full_messages
                redirect_to "/listings/rent/#{params[:rental_id]}/photos"
            end
        end
    end
    

    def favorite
        @favorite = Favorite.new(sale_listing_id: params[:sale_id], user_id: session[:user_id])

        if @favorite.save
            puts 'success!'
            redirect_to '/'
        else
            puts 'error'
            puts @favorite.errors.full_messages
            flash[:errors] = @favorite.errors.full_messages
            redirect_to '/'
        end      
    end

    def rentalfavorite
        @favorite = RentalFavorite.new(rental_listing_id: params[:rental_id], user_id: session[:user_id])

        if @favorite.save
            puts 'success!'
            redirect_to '/'
        else
            puts 'error'
            puts @favorite.errors.full_messages
            flash[:errors] = @favorite.errors.full_messages
            redirect_to '/'
        end      
    end
    
    
private
    def image_params
        params.require('/listings/sale/:sale_id/photos').permit(:sale_listing_id, { gallery: [] })
    end

    def rental_image_params
        params.require('/listings/rent/:rental_id/photos').permit(:rental_listing_id, { gallery: [] })
    end
    
    def listing_params
        params.require(:listing).permit(:address, :street, :unit, :city, :state, :zip, :user_id, :latitude, :longitude)
    end

    def listing_data
        params.require(:listing).permit(:bed, :bath, :footage, :price)
    end
    
    

    #searches gmaps based on user input from form on homepage; used in BUY, SELL, and RENT pages
    def locator location
        @listing = Geocoder.search(location).first
        if @listing == nil
            @listing = request.location
            # puts '####'
            # puts @listing.ip.inspect
            # puts '####'
            @listing = Geocoder.search(@listing.ip).first
            @testipus = Geocoder.search('216.80.4.142').first
            @lat = @listing.data['lat']
            @lng = @listing.data['lng']
            @lattest = @testipus.data['latitude']
            @lngtest = @testipus.data['longitude']

        else


            if !@listing.data
                puts 'no .data'
            end
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
    
end
