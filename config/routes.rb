Rails.application.routes.draw do
  get 'sale_listings/new'

  get 'sale_listings/create'

  get 'sale_listings/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'houses#index'

  get 'users/signin' => 'users#signin'

  post 'users/create'

  post 'users/login'

  get 'users/logout'

  get 'users/show/:user_id' => 'users#show'

  get 'users/edit/:user_id' => 'users#edit'

  patch 'users/edit/:user_id' => 'users#update'

  get 'message/contact/:to_id/:from_id' => 'message#contact'

  post 'message/contact/:to_id/:from_id' => 'message#message'

  get 'houses/maptest'

  get 'sale_listings/new'

  post 'sale_listings/create'

  post 'houses/routes' 

  get 'houses/house_buy' 

  get 'houses/house_rent'

  get 'houses/house_sell/:location' => 'houses#house_sell'

  get 'houses/house_buy/:location' => 'houses#house_buy'

  get 'houses/house_rent/:location' => 'houses#house_rent'

  post 'houses/sell'

  get 'listings/sale/:sale_id' => 'houses#show_sl'

  get 'listings/sale/:sale_id/edit' => 'houses#edit'

  post 'listings/sale/:sale_id' => 'houses#update'

  get 'listings/sale/:sale_id/photos' => 'houses#photos'

  post 'listings/sale/:sale_id/photos' => 'houses#addphotos'
end
