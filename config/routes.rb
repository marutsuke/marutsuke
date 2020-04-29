Rails.application.routes.draw do

  root 'lessons#index'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  namespace :admin do
    resources :users
    resources :admins, only: [:new, :create, :show, :update] # update, show以外
    get '/admins', to: 'admins#new' #テスト済み
    get '/login', to:'sessions#new' #テスト済み
    post '/login', to:'sessions#create' #テスト済み
    delete '/logout', to:'sessions#destroy' #テスト済み
  end

  resources :lessons, only: [:index]
end
