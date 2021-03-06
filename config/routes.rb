Chima::Application.routes.draw do
  # root :to => 'welcome#step1'
  # root :to => 'users#new'
  root :to => "home#step1"

  resource :session do
    collection {
      get :auth
    }
  end
  match 'signup' => 'users#new', :as => :signup
  match 'register' => 'users#create', :as => :register
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil
  match "/welcome/:action", :controller => "welcome", :as => "welcome"
  match "/home/:action", :controller => "home", :as => "home"

  # oauth2 callback
  match "/auth/:provider/callback" => "sessions#auth"

  resources :types do
    collection {
      get :get_brands
    }
  end
  resources :brands do
    collection {
      get :get_models
    }
  end
  resources :user_brands
  resources :users do
    member {
      get :avatar
      post :upload_avatar
      post :update_avatar
      post :cancel_avatar
    }
  end
  resources :likes
  resources :watchers

  namespace :admin do
    root :to => 'up_sizes#index'
    resources :down_sizes
    resources :up_sizes do
      collection {
        get :new_batch
        post :create_batch
      }
    end
    resources :sizes
    resources :models
    resources :brands
    resources :items
    resources :forecast_wsizes
    resources :forecast_msizes
    resources :heights
    resources :weights
    resources :types
  end
end
