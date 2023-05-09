Rails.application.routes.draw do
  resources :vote_options
  resources :questions
  # resources :slides
  # resources :presentations
  resources :users
  resources :groups
  resources :presentations do
    resources :slides do
      resources :vote_options
    end
    resources :chats
    resources :questions
    post '/current', to: 'presentations#send_current_slide'
    delete '/slides', to: 'slides#destroy_list'
    put '/slides', to: 'slides#update_list'
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
