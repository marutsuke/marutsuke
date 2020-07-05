# frozen_string_literal: true

Rails.application.routes.draw do
  root 'lessons#index' # テスト済み

  get '/login/:login_path', to: 'sessions#new', as: 'school_login' # テスト済み
  post '/login_post/:login_path', to: 'sessions#create', as: 'login_post' # テスト済み
  get '/login_post/:login_path', to: 'sessions#new' # テスト済み
  delete '/logout', to: 'sessions#destroy' # テスト済み
  resources :lessons, only: %i[index show] # テスト済み
  resources :questions, only: %i[show] do
    resources :answers, only: %i[new create]
  end
  resources :schools, only: %i[new create] # テスト済み
  get '/schools', to: 'schools#new' # テスト済み
  resources :users, only: [:new] do
    collection do
      get :mypage # テスト済み
    end
  end

  namespace :teacher do
    get '', to: 'lessons#index' # テスト済み
    get '/login', to: 'sessions#new' # テスト済み
    post '/login', to: 'sessions#create' # テスト済み
    delete '/logout', to: 'sessions#destroy' # テスト済み
    resources :users, only: %i[index new create show edit update] # テスト済み show, editはまだ
    get 'users', to: 'users#new' # テスト済み
    resources :schools, only: %i[edit update]
    resources :teachers, only: %i[index new create edit update] do # index, edit, update以外テスト済み
      member do
        post :resend_activation_mail
      end
    end
    resources :lessons, only: %i[index show new create] # テスト済み
    resources :questions, only: %i[create show] # createテスト済み
    get '/questions', to: 'lessons#index' # テスト済み
    get '/teachers', to: 'teachers#new' # テスト済み
    resources :tags, only: %i[new create]
    resources :user_tags, only: %i[create]
    get '/tags', to: 'tags#new'
    resources :account_activations, only: %i[edit]
    resources :comments, only: %i[create] # テスト済み
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
