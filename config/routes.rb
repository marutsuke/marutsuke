Rails.application.routes.draw do
 root 'books#index'
  resources :books, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :chapters, only: [:show, :new, :edit, :create, :update] do
      resources :sections, only: [:show, :new, :edit, :create,:update] do
        resources :questions, only: [:show, :new, :edit, :create, :update] do
          resources :small_questions, only: [:create, :update] do
            resources :answers, only: [:show, :create, :update]
          end
        end
      end
    end
  end
end