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

        if @data['results'][0]
            @addressform = @data['results'][0]['address_components']

            # ADD STUFF HERE
            respond_to do |format|

                format.html 
                format.json { render json: @data }

            end
        else
            #add flash error msg
            redirect_back(fallback_location: root_path)
        end


    end

    def house_buy
        locator(params[:location])

        @favorites = Favorite.where('user_id = ?', session[:user_id])

        begin
            @listings = SaleListing.includes(:image).within(10, :origin => params[:location])

            @alllistings = @listings.to_json(:include => :image)


            respond_to do |format|

                format.html 
                format.json { render json: @alllistings }

            end
        rescue Geokit::Geocoders::GeocodeError
            #add flash error msg
            redirect_back(fallback_location: root_path)
        end

    end

    def filter_buy
        if params[:filters][:bed] != "0"
           redirect_to "/houses/house_buy/#{params[:location]}/filters/#{params[:filters][:price]}/#{params[:filters][:bed]}"
        else
            redirect_to "/houses/house_buy/#{params[:location]}/filters/#{params[:filters][:price]}"
        end
    end
    
    def filtered_buy

        @listings = SaleListing.includes(:image).where('price < ?', params[:filterdata]).within(10, :origin => params[:location])

        @alllistings = @listings.to_json(:include => :image)

        puts(@alllistings)
        
        respond_to do |format|

            format.html { render 'house_buy' }
            format.json { render json: @alllistings }

        end
        
    end

    def filtered_buy_beds
     
        if params[:filterdata] == "0"
            puts "IT IS ZERO"
            @listings = SaleListing.includes(:image).where('bed = ?', params[:beds]).within(10, :origin => params[:location])
        else
            @listings = SaleListing.includes(:image).where('bed = ? AND price < ?', params[:beds], params[:filterdata]).within(10, :origin => params[:location])
        end

        @alllistings = @listings.to_json(:include => :image)

        puts(@alllistings)

        respond_to do |format|

            format.html { render 'house_buy' }
            format.json { render json: @alllistings }

        end       

    end

    def house_rent
        locator(params[:location])


        begin
            @listings = RentalListing.includes(:rental_image).within(10, :origin => params[:location])

            @alllistings = @listings.to_json(:include => :rental_image)
      
            respond_to do |format|

                format.html 
                format.json { render json: @alllistings }

            end
        rescue Geokit::Geocoders::GeocodeError
            #add flash error msg
            redirect_back(fallback_location: root_path)
        end
    end

    def filter_rent

        if params[:filters][:bed] != "0"
           redirect_to "/houses/house_rent/#{params[:location]}/filters/#{params[:filters][:price]}/#{params[:filters][:bed]}"
        else
            redirect_to "/houses/house_rent/#{params[:location]}/filters/#{params[:filters][:price]}"
        end
    end

    #backup of filter_rent method
    # def filter_rent
    #     locator(params[:location])

    #     @listings = RentalListing.includes(:rental_image).where('price < ?', params[:filters][:price]).within(10, :origin => params[:location])      

    #     @alllistings = @listings.to_json(:include => :rental_image)
  
    #     respond_to do |format|

    #         format.html { redirect_to "/houses/house_rent/#{params[:location]}/filters/#{params[:filters][:price]}" }
    #         format.json { render json: @alllistings }

    #     end

    # end
    
    def filtered_rent

        @listings = RentalListing.includes(:rental_image).where('price < ?', params[:filterdata]).within(10, :origin => params[:location])

        @alllistings = @listings.to_json(:include => :rental_image)

        puts(@alllistings)
        
        respond_to do |format|

            format.html { render 'house_rent' }
            format.json { render json: @alllistings }

        end
        
        
    end

    def filtered_rent_beds
     
        if params[:filterdata] == "0"
            puts "IT IS ZERO"
            @listings = RentalListing.includes(:rental_image).where('bed = ?', params[:beds]).within(10, :origin => params[:location])
        else
            @listings = RentalListing.includes(:rental_image).where('bed = ? AND price < ?', params[:beds], params[:filterdata]).within(10, :origin => params[:location])
        end

        @alllistings = @listings.to_json(:include => :rental_image)

        puts(@alllistings)

        respond_to do |format|

            format.html { render 'house_rent' }
            format.json { render json: @alllistings }

        end       

    end
    
    def sell

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
            redirect_to '/'
        else
            puts @favorite.errors.full_messages
            puts session[:user_id]
            flash[:errors] = @favorite.errors.full_messages
            redirect_to '/'
        end      
    end

    def rentalfavorite
        @favorite = RentalFavorite.new(rental_listing_id: params[:rental_id], user_id: session[:user_id])

        if @favorite.save

            redirect_to '/'
        else

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
