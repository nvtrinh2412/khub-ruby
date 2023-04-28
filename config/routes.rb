Rails.application.routes.draw do
  # resources :slides
  # resources :presentations
  resources :users
  resources :groups
  resources :presentations do
    resources :slides
    resources :chats
    post '/current', to: 'presentations#send_current_slide'
  end
  post '/auth/login', to: 'auth#create'
  post '/auth/sign_up', to: 'users#create'
  post '/auth/logout', to: 'auth#destroy'
  post '/auth/refresh-tokens', to: 'auth#refresh_tokens'
  # for socket connection
  mount ActionCable.server => "/cable"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
