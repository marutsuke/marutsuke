Rails.application.routes.draw do

  root 'lessons#index'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  resources :lessons, only: [:index]
end
