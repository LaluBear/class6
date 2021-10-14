Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/profile/:name', to: 'user#user_profile'
  get '/feed', to: 'user#feed'
  get '/main', to: 'user#login'
  
  get '/new_post', to: 'user#new_post'
  get '/follow/:id', to: 'user#follow'
  get '/unfollow/:id', to: 'user#unfollow'
  get '/new_user', to: 'user#new_user'
  
  post '/create_user', to: 'user#create_user'
  post '/create_post', to: 'user#create_post'
  post '/login_attempt', to: 'user#login_attempt'
end
