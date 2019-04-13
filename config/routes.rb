Rails.application.routes.draw do
 root 'books#index'
 resources :books, only:[:index,:new,:create,:edit,:update,:destroy]
 resources :sections, only: [:create,:update]
 resources :chapters, only: [:create,:update]
end
