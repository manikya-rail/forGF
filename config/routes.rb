Rails.application.routes.draw do
  require 'sidekiq/web'
  namespace :admin do
    post "search", to: "search#search", as: 'search'
    resources :holes, except: [:index, :create, :new] do
      member do
        get :hole_images
        put :remove_map
        put :remove_image
        delete :remove_hole_image
      end
      collection do
        get :get_yardages
        post :add_image
        post :add_logo_hyperlink
        post :add_logo_image
        post :add_map
        post :add_hole_image
        post :add_yardages
        post :set_images_rank
      end
    end
    resources :score_cards, except: [:index, :create]
    resources :networks
    resources :resorts, except: [:new, :show] do
      get :courses_list
      get :courses
      get :add_course
    end
    resources :courses do
      get :holes_list
      post :update_holes
      collection do
        get :add_playlist_item
        get :add_scorecard
        post :remove_course_image
        post :remove_scorecard_image
      end
    end
    resources :ads, only: [:show, :index] do
      collection do
        post :add_image
      end
    end
    resources :videos, only: [:create, :show, :destroy] do
      resources :tags, only: [:create]
    end
    resources :tags, only: [:destroy]
    resources :users, only: [:index]

    # SG - non-restful routes
    # post "videos/create", to: 'videos#create' ,as: 'video_create'
    # get "videos/:id" , to: 'videos#show' ,as: 'video'
    # delete "videos/:id" ,to: 'videos#destroy', as: 'delete_video'
    # post "tags/:video_id/save" ,to: 'tags#create', as: 'create_tag'
    # delete "tags/:id" ,to: 'tags#destroy', as: 'delete_tag'
    # get "users/index"
    # post "courses/remove_course_image", to: 'courses#remove_course_image'
    # post "courses/remove_scorecard_image", to: 'courses#remove_scorecard_image'
    # get "/add_playlist_item", to: 'courses#add_playlist_item'
    # get "/add_scorecard", to: 'courses#add_scorecard'
    # post "holes/add_image" ,to: 'holes#add_image', as: 'add_image'
    # post "holes/add_logo_hyperlink" ,to: 'holes#add_logo_hyperlink', as: 'add_logo_hyperlink'
    # post "holes/add_logo_image" ,to: 'holes#add_logo_image', as: 'add_logo_image'
    # put "holes/image/:id" ,to: 'holes#remove_image', as: 'remove_image'
    # post "holes/add_map" ,to: 'holes#add_map', as: 'add_map'
    # put "holes/map/:id" ,to: 'holes#remove_map', as: 'remove_map'
    # post "holes/add_hole_image" ,to: 'holes#add_hole_image', as: 'add_hole_image'
    # delete "holes/gallery/:id" ,to: 'holes#remove_hole_image', as: 'remove_hole_image'
    # post "holes/add_yardages" ,to: 'holes#add_yardages', as: 'add_yardages'
    # get "/get_yardages", to: 'holes#get_yardages', as: 'get_hole_yardages'
    # post "ads/add_image" ,to: 'ads#add_image', as: 'upload_image'
    # post "courses/:course_id/update_holes", to: "courses#update_holes", as: 'update_holes_details'

    # SG - unused actions/routes
    # get "courses/holes/:id", to: 'courses#holes',as: 'holes_create'
    # put "holes/logo_image/:id" ,to: 'holes#remove_logo_image', as: 'remove_logo_image'
    # resources :amenities
    #resources :locations
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
    resources :users, only:[:show, :update]
    resources :videos, only:[:show]
    resources :lists, only: [:create, :show]
    resources :reviews, only: [:show]
    resources :scores, only: [:create, :show]
    post "lists/:id/add_course", to: 'lists#add_course', as: 'add_course'
    post "courses/:id/add_user", to: 'courses#add_user', as: 'add_user'
    get "users/:id/lists" , to: 'users#lists', as: 'user_lists'
  end

  root to: "admin/courses#new"

  namespace :embed do
    # resources :pages, only: :show, path: "" # -> domain.com/embed/1
    get "show/:id", to: 'pages#show'
    get ":id", to: 'pages#display',as: 'display_info'
    get "dis2/:id", to: 'pages#dis2'
    get "hole/:id", to: 'pages#hole_by_hole',as: 'hole_info'
    get "course/:id", to: 'pages#course_home',as: 'course_info'
    post "pages/update_tee_scorecard", to: 'pages#update_tee_scorecard'
  end
  mount Sidekiq::Web, at: '/sidekiq'
end
