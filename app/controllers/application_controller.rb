class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :unread_messages

  def require_login
    redirect_to '/users/signin' unless session[:user_id]
  end


  def unread_messages
    @messages = Message.all
    puts '#####'
    puts @messages.inspect
    puts '#####'
  end


end
