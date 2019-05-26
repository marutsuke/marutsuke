Rails.application.routes.draw do

  root 'books#index'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  namespace :admin do
    resources :users
  end

 resources :publish, only: [:update]

 resources :marutsuke, only: [:create, :show]

 resources :books, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
   resources :chapters, only: [:show, :new, :edit, :create]
 end

  resources :chapters, only: [:destroy,:update] do
    resources :sections, only: [:show, :new, :edit, :create]
  end

  resources :sections, only: [:update] do
    resources :questions, only: [:index, :show, :new, :create, :update]
  end

  resources :questions, only: [:destroy,:edit]

  resources :questions, only: [] do
    resources :small_questions, only: [:index, :show, :new, :edit, :create, :update]
  end

  resources :small_questions, only: [:destroy]

  resources :small_questions, only: [] do
    resources :answers, only: [:show, :create, :update]
  end

  resources :buy, only: [:index,:new,:create,:destroy,:show] do
    member do
      get 'buy'
    end
  end

end
