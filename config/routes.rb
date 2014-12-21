Chima::Application.routes.draw do
  # root :to => 'welcome#step1'

  mount Resque::Server, :at => "/resque"
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

  namespace :v1 do
    post '/my/forecast', to: 'my#forecast'
    post '/my/actual_size', to: 'my#new_actual_size'
    get '/my/actual_size', to: 'my#actual_size'
    get '/weights', to: 'weights#index'
    get '/heights', to: 'heights#index'
    get '/chima', to: 'chima#index'
    post '/questions', to: 'questions#create'
    post '/reserves', to: 'reserves#create'
    post '/reserves/:id', to: 'reserves#show'

    post '/invitations', to: 'invitations#create'

    post '/files', to: 'files#create'

    get '/user', to: 'users#show'
    post '/user', to: 'users#patch'
    get '/user/reserves', to: 'users#reserves'
    get '/user/coupons', to: 'users#coupons'
    get '/user/interactions', to: 'users#interactions'
    get '/user/invitations', to: 'users#invitations'

    resources :tailors do
      resources :tailor_comments, only: [:index,:create]
    end

    resources :bs_cities do
      resources :bs_districts, only: [:index]
    end

    resources :users do
      collection {
        post :signup
        post :signin
        post :oauth
        delete :signout
        post :patch
        post :avatar
      }
    end

  end

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
    resources :questions do
      resources :answers
    end
    resources :reserves
    resources :shops
    resources :coupons
    resources :bs_cities do
      resources :bs_districts
    end

    resources :bs_districts do
      resources :bs_areas
    end

    resources :tailors
    resources :tailor_areas

    # resources :bs_areas
    resources :users do
      member {
        post :update_role
      }
    end
  end
  resources :questions
end
