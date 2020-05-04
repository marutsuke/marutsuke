# frozen_string_literal: true

Rails.application.routes.draw do
  root 'lessons#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
    resources :admins, only: %i[new create] # テスト済み
    get '/admins', to: 'admins#new' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
  end

  namespace :teacher do
    resources :users, only: %i[index new create] # テスト済み
    get 'users', to: 'users#new' # テスト済み
    resources :teachers, only: %i[new create] # テスト済み
    get '/teachers', to: 'teachers#new' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
  end

  resources :lessons, only: [:index]
  resources :schools, only: %i[new create] # テスト済み
  get '/schools', to: 'schools#new' # テスト済み
end
