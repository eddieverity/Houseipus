Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'houses#index'

  get 'users/signin' => 'users#signin'

  post 'users/create'

  post 'users/login'

  get 'users/logout'

  get 'houses/maptest'


  post 'houses/routes' => 'houses#routes'

  get 'houses/house_buy' => 'houses#buy'
  get 'houses/house_rent' => 'houses#rent'
  get 'houses/house_sell' => 'houses#sell'

  

end
