Rails.application.routes.draw do

namespace :admin do
  resources :holes
  resources :score_cards
  resources :amenities
  resources :networks
  resources :resorts
  resources :locations
  resources :courses
end

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: {format: :json} do
    delete '/sessions', :to => 'sessions#destroy'  
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    resources :pages, only: [:index]
  end

  root :to => "admin/courses#new"
end
