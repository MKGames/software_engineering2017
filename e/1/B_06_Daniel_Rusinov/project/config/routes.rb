Rails.application.routes.draw do
  resources :orders
  resources :users
  
  root 'users#new'
  get '/user', to: 'users#new'
  get '/order', to: 'orders#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
