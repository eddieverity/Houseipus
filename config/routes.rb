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

end
