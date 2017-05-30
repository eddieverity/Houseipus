class MessagesController < ApplicationController
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
end
