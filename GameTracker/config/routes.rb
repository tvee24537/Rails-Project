Rails.application.routes.draw do

  get '/' => 'sessions#home' 
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new' 
  post '/signup' => 'users#create' 
  delete '/logout' => 'sessions#destroy'
  get '/most_popular' => 'games#most_popular' 

  get '/auth/:provider/callback' => 'sessions#create'
 
  resources :categories   
  resources :reviews
  resources :games do
    resources :reviews, only: [:new, :index]
  end
  
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
