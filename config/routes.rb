Rails.application.routes.draw do
  root 'users#welcome'

  get '/home' => 'projects#home'

  get '/projects/new' => 'projects#new'

  post '/projects' => 'projects#create'

  get '/projects/:id' => 'projects#show'

  get '/projects/:id/edit' => 'projects#edit'

  patch '/projects/:id/add' => 'projects#add_user'

  patch '/projects/:id/remove' => 'projects#remove_user'

  get '/projects/:id/complete' => 'projects#completed_tasks'

  put '/projects/:id' => 'projects#update'

  patch '/projects/:id' => 'projects#update'

  delete '/projects/:id' => 'projects#delete'

  post '/login' => 'users#login'

  get '/logout' => 'users#logout'

  get '/users' => 'users#index'

  post '/users' => 'users#create'

  get '/users/:id' => 'users#show'

  get '/users/:id/edit' => 'users#edit'

  patch '/users/:id' => 'users#update'

  delete '/users/:id' => 'users#delete'

  get '/tasks' => 'tasks#index'

  post '/tasks/new' => 'tasks#create'

  post '/projects/:id/tasks/new' => 'tasks#create'

  get '/tasks/complete' => 'tasks#completed'

  get '/tasks/:id' => 'tasks#edit'

  put '/tasks/:id' => 'tasks#update'

  patch '/tasks/:id' => 'tasks#update'

  delete '/tasks/:id' => 'tasks#delete'

  post '/comments/new' => 'comments#create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
