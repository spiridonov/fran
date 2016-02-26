Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    resources :users do 
      post :ban, on: :member
      post :unban, on: :member
      get :banned, on: :collection
      get :lazy, on: :collection
      get :users_report, on: :collection
      get :workouts_report, on: :collection
    end
    resources :user_workouts, only: [:destroy, :create] do
      post :mark_as_visited, on: :member
      post :mark_as_not_visited, on: :member
    end
    resources :workouts do
      post :copy_previous_week, on: :collection
    end
    resources :schedules
    resources :boxes
    resources :price_requests do
      post :close, on: :member
    end
  end

  resources :workouts do
    post :will_go, on: :member
    post :will_not_go, on: :member
  end

  get 'vk_callback', to: 'auth#vk_callback'
  get 'fb_callback', to: 'auth#fb_callback'
  post 'auth/sign_out', to: 'auth#sign_out'
  get 'auth/sign_in', to: 'auth#sign_in'
  post 'ask_for_price', to: 'home#ask_for_price'
end
