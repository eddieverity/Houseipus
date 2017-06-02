class UsersController < ApplicationController

    def signin
    end
    
    def create
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            session[:user_email] = @user.email
            redirect_to '/'
        else
            flash[:register] = @user.errors.full_messages
            redirect_back(fallback_location: users_signin_path)
        end
    end
    
    def login
        @user = User.find_by('email = ?', params[:user][:email])

        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            session[:user_email] = @user.email
            redirect_to '/'
        else
            flash[:login] = ["Invalid Email or Password"]
            redirect_back(fallback_location: users_signin_path)
        end
    end

    def show
        @user = User.find_by('id = ?', params[:user_id])
        @sale_listings = SaleListing.where('user_id = ?', params[:user_id])
        @rental_listings = RentalListing.where('user_id = ?', params[:user_id])
        @inbox = Message.where('receiver_id = ?', session[:user_id])
        @outbox = Message.where('sender_id = ?', session[:user_id])

        @favorite_sales = Favorite.includes(:sale_listing).where('user_id = ?', session[:user_id])
        @favorite_rentals = RentalFavorite.includes(:rental_listing).where('user_id = ?', session[:user_id])
        puts '################'
        puts @favorite_sales.inspect

        puts '################'
    end

    def edit
        @user = User.find_by('id = ?', params[:user_id])
    end

    def update
        @user = User.find_by('id = ?', params[:user_id])
        @user.update(user_params)
        redirect_to '/'
    end

    def logout
        reset_session
        redirect_to '/'
    end

private
    def user_params
        params.require(:user).permit(:email, :agent, :password, :password_confirmation, :first_name, :last_name, :addr, :phone, :opt)
    end
    def message_params
        params.require(:message).permit(:title, :content, :to_id, :from_id)
    end
end
