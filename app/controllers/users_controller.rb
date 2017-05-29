class UsersController < ApplicationController

    def signin
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
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
            redirect_to '/'
        else
            flash[:login] = ["Invalid Email or Password"]
            redirect_back(fallback_location: users_signin_path)
        end
    end

    def logout
        reset_session
        redirect_to '/'
    end

private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
