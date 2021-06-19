Rails.application.routes.draw do
  get 'reservations', to: 'reservations#index'
  resources :rooms
  get 'sessions/new'
  get '/signup',  to: 'users#new'
  root 'rooms#index'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  
  resources :rooms do
    resources :reservations
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
