class UsersController < ApplicationController

    def signin
    end
    
    def create
        @user = User.new(user_params)
        puts @user
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
    end

    def edit
        @user = User.find_by('id = ?', params[:user_id])
    end

    def update
        @user = User.find_by('id = ?', params[:user_id])
        @user.update(user_params)
        redirect_to '/'
    end

    def contact
        @user = User.find_by('id = ?', params[:to_id])
    end

    def message
 
        @user = User.find_by('id = ?', params[:to_id])
        @message = Message.new(title: params[:message][:title], content: params[:message][:content], sender_id: params[:from_id], receiver_id: params[:to_id])
        if @message.save
            UserMailer.message_email(@user)

            redirect_to "/users/show/#{@user[:id]}"
            #redirect_to '/'
        else
            flash[:message] = @message.errors.full_messages
            redirect_to '/'
        end
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
