Rails.application.routes.draw do

devise_for :users
devise_scope :user do
	root :to => 'categories#index'
end
get 'users' => 'users#users_admin', as: :users
put 'users/:id/approved' => 'users#approved', as: :approved
put 'users/:id/disapproved' => 'users#disapproved', as: :disapproved
put 'users/:id/set_admin' => 'users#set_admin', as: :set_admin
put 'users/:id/unset_admin' => 'users#unset_admin', as: :unset_admin
put 'users/public' => 'users#public', as: :public
put 'users/private' => 'users#private', as: :private
resources :users, only: [:show, :edit, :update, :destroy]

resources :categories, only: [:index, :new, :create] do
	resources :images do 
		get :download, on: :member 
		get :download_sd, on: :member 
	end
end
resources :categories, path: "", except: [:index, :new, :create]
get '*id', to: 'categories#show'



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
