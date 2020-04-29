Rails.application.routes.draw do

  root 'lessons#index'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  namespace :admin do
    resources :users
    resources :admins, only: [:new, :create, :show, :update]
    get '/admins', to: 'admins#new'
    get '/login', to:'sessions#new'
    post '/login', to:'sessions#create'
    delete '/logout', to:'sessions#destroy'
  end

  resources :lessons, only: [:index]
end
