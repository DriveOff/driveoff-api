Rails.application.routes.draw do
  root 'static_pages#home'
  
  constraints format: :json do
    get '/users/search' => 'users#search', as: :users_search, defaults: { format: 'json' }
    resources :users, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' } do
      resources :trips, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
      resources :redemptions, only: [:index, :show, :create, :destroy], defaults: { format: 'json' }
    end
    get '/users/:id/friends' => 'users#friends', as: :user_friends, defaults: { format: 'json' }
    patch '/users/:id/add_friend/:id2' => 'users#add_friend', as: :user_add_friend, defaults: { format: 'json' }
    put '/users/:id/add_friend/:id2' => 'users#add_friend', defaults: { format: 'json' }
  
    resources :businesses, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
    resources :rewards, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
    
    post 'login' => 'user_sessions#create', :as => :login, defaults: { format: 'json' }
    delete 'logout' => 'user_sessions#destroy', :as => :logout, defaults: { format: 'json' }
  end
end
