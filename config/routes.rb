Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    resources :users
    resources :workouts
    resources :boxes
    resources :schedules
  end

  resources :workouts do
    post :will_go, on: :member
    post :will_not_go, on: :member
  end

  get 'vk_callback', to: 'auth#vk_callback'
  post 'auth/sign_out', to: 'auth#sign_out'
  get 'auth/sign_in', to: 'auth#sign_in'

end
