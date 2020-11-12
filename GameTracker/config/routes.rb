Rails.application.routes.draw do
  root "sessions#home"
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  
  delete '/logout' => 'sessions#destroy'
  
  #resources :categories
  resources :comments
  resources :users do
    resources :games, only: [:new, :create, :index]
  end 
  resources :games
    resources :comments, only: [:new, :create, :index]
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
