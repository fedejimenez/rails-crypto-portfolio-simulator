Rails.application.routes.draw do
  # Homepage
  get 'home/about'
  root 'home#index'

  # Signup. The first renders a form, the second receives the form and create a user in the database.
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
