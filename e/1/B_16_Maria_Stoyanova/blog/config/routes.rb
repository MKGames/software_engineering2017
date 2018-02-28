Rails.application.routes.draw do
  resources :orders
  resources :users
	resources :articles, only: [:index, :create, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
