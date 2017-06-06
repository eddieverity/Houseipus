class MessagesController < ApplicationController
    def contact
        @user = User.find_by('id = ?', params[:to_id])
    end

    def message
 
        @user = User.find_by('id = ?', params[:to_id])
        @message = Message.new(title: params[:message][:title], content: params[:message][:content], sender_id: params[:from_id], receiver_id: params[:to_id], viewed: false)
        

        if @message.save
            puts '#####'
            puts @user.inspect
            puts '#####'

            #MessageMailer.message_email(@user).deliver_later

            #if @user.opt == true
               #  UserMailer.message_email(@user).deliver_now


            #end
            #else

            redirect_to "/messages/show/#{session[:user_id]}"
            #redirect_to '/'
    
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
end
