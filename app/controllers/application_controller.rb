class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   def require_login
    redirect_to '/users/signin' unless session[:user_id]
  end
end
