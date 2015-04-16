Rails.application.routes.draw do
  get 'home/index'

  devise_for :employees, controllers: {sessions: 'employees/sessions'}, skip: [:registrations]

  resources :tools

  resources :task_domains

  resources :task_types

  resources :tasks do
    get 'pick_domain', on: :collection
    get 'pick_type',   on: :collection
  end

  resources :place_types

  resources :places

  resources :employee_types

  resources :responsibilities

  resources :services, only: [:new, :create, :destroy]

  resources :employees
  resources :employees do
    member do
      patch 'assign_task', controller: :employees, action: :assign_task
    end
  end
  match 'assign_task' => 'employees#assign_task', via: [:post]

  root 'home#index' 

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
