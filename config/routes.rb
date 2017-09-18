Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    root 'static_pages#home'
  
    #Devise routes
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
    
    resources :users, only: [:show, :index]
    resources :tags, only: [:index, :show, :create]
    resources :channels, only: [:index, :show]
    
end
