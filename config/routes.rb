Rails.application.routes.draw do
  resources :users
  resources :groups
  get '/current_user', to: 'auth#show'
  post '/auth/login', to: 'auth#create'
  post '/auth/sign_up', to: 'users#create'
  post '/auth/logout', to: 'auth#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
