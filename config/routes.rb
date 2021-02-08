Rails.application.routes.draw do
  root 'lesson_groups#index'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login_post', to: 'sessions#create', as: 'login_post'
  get '/login_post', to: 'sessions#new'
  get '/line_api/sign_up_by_line', to: 'line_api#sign_up_page_by_line'
  delete '/logout', to: 'sessions#destroy'
  resources :lessons, only: %i[show]
  resources :lesson_groups, only: %i[index show]
  resources :questions, only: %i[show] do
    resources :answers, only: :new
  end
  resources :question_statuses, only: [] do
    member do
      post :change_to_will_do
      post :change_to_maybe_do
      post :change_to_will_not_do
    end
  end
  resources :notification_permission, only: %i[] do
    collection do
      post :permit
      delete :cancel
    end
  end
  resources :terms, only: %i[index] do
    collection do
      get :privacy_policy
      get :terms
      get :rules
    end
  end

  resources :user_account_settings, only: %i[index]
  resources :cancels, only: %i[new create edit update]
  get 'cancels', to: 'cancels#new'

  resources :answers, only: %i[create] do
    get :image_show, on: :member
    resources :comments, only: [] do
      get :image_show, on: :member
    end
  end

  resources :schools, only: %i[new create]
  get '/schools', to: 'schools#new'
  resources :school_users, only: %i[index] do
    post :select_school, on: :member
  end
  resources :join_requests, only: %i[new create update]
  resources :lesson_group_requests, only: %i[index]
  resources :lesson_groups, only: %i[] do
    resources :lesson_group_requests, only: %i[create]
  end

  resources :users, only: %i[new] do
    collection do
      get :mypage
      get :edit
      patch :update
      post :change_school #いらなくなったかも
    end
  end
  resources :school_user_activations, only: %i[edit new create]
  resources :line_api, only: %i[create new] do
    collection do
      post :send_message
    end
  end

  namespace :user_authentications do
    resources :line_authentications, only: %i[] do
      collection do
        post :line_login_authentication
        post :line_sign_up_authentication
        get :line_login
        get :line_sign_up
        get :user_form
        post :create_user
      end
    end
    resources :email_authentications, only: %i[new create] do
      collection do
        get :user_form
        post :create_user
      end
    end
  end

  namespace :teacher do
    get '', to: 'top#top'
    get '/login/:login_path', to: 'sessions#new', as: 'school_login'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/questions', to: 'question_set#index'
    resources :users, only: %i[index show edit] do
      get :lesson_groups, on: :member
      resources :school_building_users, only: %i[new destroy update] do
        post :create, on: :member
      end
      resources :lesson_group_users, only: %i[new destroy] do
        post :create, on: :member
      end
    end
    resources :school_users, only: %i[edit update destroy] do
      post :create, on: :member
    end
    resources :schools, only: %i[index edit update]
    resources :teachers, only: %i[index new create edit update show] do
      member do
        post :resend_activation_mail
      end
      resources :school_building_teachers, only: %i[new update destroy] do
        post :create, on: :member
      end
    end
    resources :lessons, only: %i[show edit update] do
      resources :questions, only: :new
    end

    resources :question_statuses, only: [] do
      resources :comments, only: %i[new create]
    end
    resources :answer_checks, only: %i[index show] do
      get :lessons_show, on: :member
      get :question_statuses_show, on: :member
    end

    resources :question_set, only: %i[index show] do
      get :lessons_show, on: :member
    end

    resources :questions, only: %i[create edit update destroy] do
      post :publish, on: :member
    end
    get '/questions', to: 'lessons#index'
    get '/teachers', to: 'teachers#new'
    resources :account_activations, only: %i[edit]
    resources :comments, only: %i[index]
    resources :school_buildings, only: %i[index new create show update] do
      get :invitation_manage, on: :member
    end
    resources :school_building_settings, only: %i[index]
    resources :lesson_groups, only: %i[index new show create edit update destroy] do
      resources :lessons, only: %i[index new create]
    end
    # resources :user_invitation_mails, only: %i[new create]
    resources :join_requests, only: %i[index] do
      member do
        patch :accept
        patch :reject
      end
    end
    resources :lesson_group_requests, only: %i[index] do
      member do
        patch :accept
        patch :reject
      end
    end
    resources :mypage, only: %i[index] do
      get :edit, on: :collection
      patch :update, on: :collection
    end
    resources :image_changes, only: %i[] do
      get :edit, on: :collection
      patch :update, on: :collection
    end
    resources :password, only: %i[] do
      get :edit, on: :collection
      patch :update, on: :collection
      get :edit_other, on: :member
      patch :update_other, on: :member
    end
  end

  namespace :admin do
    get '', to: 'users#index'
    resources :users, only: %i[index]
    resources :admins, only: %i[new create]
    get '/admins', to: 'admins#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
end
