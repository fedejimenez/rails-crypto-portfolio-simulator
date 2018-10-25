Rails.application.routes.draw do
  # Homepage
  root 'home#index'
  get 'home/about'
  get 'home/lookup'
  post 'home/lookup' => 'home/lookup'


  # Signup. The first renders a form, the second receives the form and create a user in the database.
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # these routes are for showing users a login form and log in / out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
