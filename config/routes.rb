Rails.application.routes.draw do

namespace :admin do
  resources :holes
  resources :score_cards
  resources :amenities
  resources :networks
  resources :resorts
  resources :locations
  resources :courses
  get "users/index"
  post "videos/create"
  get "videos/:id" , to: 'videos#show' ,as: 'video'
end

  devise_for :admins
  devise_for :users
  # put '/users', :to => 'devise/registrations#update', :as => :update_user
  namespace :v1, defaults: {format: :json} do
    delete '/sessions', :to => 'sessions#destroy'  
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    resources :pages, only: [:index]
    resources :courses, only:[:index,:show]
    resources :users, only:[:show]
  end

  root to: "admin/courses#new"
end
