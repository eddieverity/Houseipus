class MessagesController < ApplicationController
    def contact
        if session[:user_id]
            @user = User.find_by('id = ?', params[:to_id])
        else
            redirect_to '/users/signin'
        end
    end

    def message
 
        @user = User.find_by('id = ?', params[:to_id])
        @message = Message.new(title: params[:message][:title], content: params[:message][:content], sender_id: params[:from_id], receiver_id: params[:to_id], viewed: false)
        @url = 'http://www.google.com'

        if @message.save

            if @user.opt == true
                puts '#####'
                puts @message.content.inspect
                puts '#######'
                MessageMailer.message_email(@user).deliver_later
            end


            redirect_to "/messages/show/#{session[:user_id]}"
    
        else
            puts 'hit error'
            flash[:message] = @message.errors.full_messages
            redirect_to '/'
        end
    end

    def viewed
        @message = Message.find(params[:id])
        if @message.viewed == false
            @message.viewed = true
            @message.save
        end

    end
    
    def show
        @user = User.find_by('id = ?', session[:user_id])
        @inbox = Message.where('receiver_id = ?', session[:user_id]).reverse
        @outbox = Message.where('sender_id = ?', session[:user_id]).reverse
        @contacts = User.where(id: @user.contacts)
    end

    def delete
        @message = Message.find_by('id = ?', params[:message_id])
        @message.destroy
        redirect_back(fallback_location: users_signin_path)
    end
end
