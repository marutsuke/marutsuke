# frozen_string_literal: true

Rails.application.routes.draw do
  root 'lessons#index' # テスト済み

  get '/login', to: 'sessions#new' # テスト済み
  post '/login', to: 'sessions#create' # テスト済み
  delete '/logout', to: 'sessions#destroy' # テスト済み

  namespace :admin do
    get '', to: 'users#index'
    resources :users, only: %i[index] # テスト済み
    resources :admins, only: %i[new create] # テスト済み
    get '/admins', to: 'admins#new' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
  end

  namespace :teacher do
    get '', to: 'lessons#index'
    resources :users, only: %i[index new create] # テスト済み
    get 'users', to: 'users#new' # テスト済み
    resources :teachers, only: %i[new create] # テスト済み
    resources :lessons, only: %i[index show new create] # テスト済み showまだ
    resources :questions, only: %i[create show] # createテスト済み
    get '/questions', to: 'lessons#index' # テスト済み
    get '/teachers', to: 'teachers#new' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
  end

  resources :lessons, only: [:index] # テスト済み
  resources :schools, only: %i[new create] # テスト済み
  get '/schools', to: 'schools#new' # テスト済み
end
