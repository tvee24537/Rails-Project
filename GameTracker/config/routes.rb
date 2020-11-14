Rails.application.routes.draw do
  resources :categories 
  get '/' => 'sessions#home' 
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new' 
  post '/signup' => 'users#create' 
  delete '/logout' => 'sessions#destroy'
  get '/most_popular' => 'games#most_popular' 

  get '/auth/:provider/callback' => 'sessions#create'
 
  
  resources :reviews
  resources :games do
    resources :reviews, only: [:new, :index]
  end
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
