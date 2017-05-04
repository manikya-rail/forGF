Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: {format: :json} do
    delete '/sessions', :to => 'sessions#destroy'  
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    resources :pages, only: [:index]
  end

  root :to => "admins#create_course"
end
