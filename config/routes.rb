Rails.application.routes.draw do
  root 'lessons#index'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login_post', to: 'sessions#create', as: 'login_post'
  get '/login_post', to: 'sessions#new'
  get '/line_api/sign_up_by_line', to: 'line_api#sign_up_page_by_line'
  delete '/logout', to: 'sessions#destroy'
  resources :lessons, only: %i[index show]
  resources :questions, only: %i[show] do
    resources :answers, only: :new
    resources :question_statuses, only: [] do
      collection do
        post :will_do
        post :maybe_do
        post :will_not_do
      end
    end
  end
  resources :question_statuses, only: [] do
    member do
      post :change_to_will_do
      post :change_to_maybe_do
      post :change_to_will_not_do
    end
  end

  resources :answers, only: %i[create] do
    member do
      get :image_show
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
        post :line_authentication
        get :line_logged_in
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
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :users, only: %i[index show  edit] do
      resources :school_building_users, only: %i[new create destroy]
      resources :lesson_group_users, only: %i[new create destroy]
    end
    get 'users', to: 'users#new'
    resources :schools, only: %i[edit update]
    resources :manage_menus, only: %i[index]
    resources :teachers, only: %i[index new create edit update show] do
      member do
        post :resend_activation_mail
      end
      resources :school_building_teachers, only: %i[new create destroy]
    end
    resources :lessons, only: %i[index show edit update] do
      resources :questions, only: :new
    end

    resources :question_statuses, only: [] do
      resources :comments, only: %i[new create]
      # TODO: 不要なので消す予定 2020/11/03
      # resources :answer_checks, only: [] do
      #   get :checking, on: :collection
      #   post :check, on: :collection
      # end
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
    resources :lesson_groups, only: %i[index new show create edit update] do
      resources :lessons, only: %i[new create]
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
