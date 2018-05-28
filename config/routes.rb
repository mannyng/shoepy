Rails.application.routes.draw do
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'campaigns#index'
 resources :users, only: [:create,:new, :show, :index] do
  collection do
    post 'confirm'
    post 'login'
  end
  member do
    get 'my_line_items'
    get 'user_type'
  end
  resources :customers, only: [:create,:show,:index]
 end
 resources :customers, only: [:create,:show,:index,:update] do
     member do
      get 'myposts'
      get 'my_friends'
      get 'myconvos'
     end
     collection do
      get 'live_users'
     end
     
    resources :customer_connects do
      member do
       get 'confirm'
       get 'accept'
       get 'customer_connect_discussion'
      end
      
     collection do
      get 'my_connections'
     end
    end
    resources :messages do
     collection do
      get 'my_messages'
     end
     member do
      get 'read'
     end
    end 
 end
 

 resources :conversations, only: [:show,:create]
 resources :messages, only: [:create]
 resources :campaigns, only: [:create]
 resources :products
 resources :carts
 resources :line_items
end
