Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'campaigns#index'
 resources :users, only: [:create,:new, :show, :index] do
  collection do
    post 'confirm'
    post 'login'
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
    end 
 end
 resources :employer_posts do
     resources :insights, :job_locations
     collection do
      get 'public_jobs'
      get 'private_jobs'
      get 'my_point'
      get 'offer_list'
      get 'most_recent_list'
     end
 end
 resources :employee_posts do
     #resources :insights, :job_locations
     collection do
      get 'public_requests'
      get 'recent_requests'
     # get 'my_point'
     end
 end
 resources :conversations, only: [:show,:create]
 resources :messages, only: [:create]
 resources :campaigns, only: [:create]
end
