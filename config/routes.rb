Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

 root 'books#index'

 resources :books, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
   resources :chapters, only: [:show, :new, :edit, :create]
 end

  resources :chapters, only: [:destroy,:update] do
    resources :sections, only: [:show, :new, :edit, :create,:update]
  end

  resources :sections, only: [] do
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

end
