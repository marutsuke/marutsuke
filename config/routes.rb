# frozen_string_literal: true

Rails.application.routes.draw do
  root 'lessons#index' # テスト済み

  get '/login', to: 'sessions#new' # テスト済み
  post '/login', to: 'sessions#create' # テスト済み
  delete '/logout', to: 'sessions#destroy' # テスト済み
  resources :lessons, only: %i[index show] # テスト済み
  resources :questions, only: %i[show]
  resources :answers, only: %i[create]
  resources :schools, only: %i[new create] # テスト済み
  get '/schools', to: 'schools#new' # テスト済み

  namespace :teacher do
    get '', to: 'lessons#index' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
    resources :users, only: %i[index new create show edit] # テスト済み show, editはまだ
    get 'users', to: 'users#new' # テスト済み
    resources :teachers, only: %i[new create] # テスト済み
    resources :lessons, only: %i[index show new create] # テスト済み
    resources :questions, only: %i[create show] # createテスト済み
    get '/questions', to: 'lessons#index' # テスト済み
    get '/teachers', to: 'teachers#new' # テスト済み
    resources :tags, only: %i[new create]
    resources :user_tags, only: %i[create]
    get '/tags', to: 'tags#new'
  end

  namespace :admin do
    get '', to: 'users#index' # テスト済み
    resources :users, only: %i[index] # テスト済み
    resources :admins, only: %i[new create] # テスト済み
    get '/admins', to: 'admins#new' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
  end
end
