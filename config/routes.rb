Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    resources :users
    resources :user_workouts, only: [:destroy, :create] do
      post :mark_as_visited, on: :member
      post :mark_as_not_visited, on: :member
    end
    resources :workouts
    resources :schedules
    resources :boxes
  end

  resources :workouts do
    post :will_go, on: :member
    post :will_not_go, on: :member
  end

  get 'vk_callback', to: 'auth#vk_callback'
  get 'fb_callback', to: 'auth#fb_callback'
  post 'auth/sign_out', to: 'auth#sign_out'
  get 'auth/sign_in', to: 'auth#sign_in'

end
