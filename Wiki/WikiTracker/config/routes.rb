WikiTracker::Application.routes.draw do
  resources :memberships

  resources :comment_stories
  match 'user_stories/:id/edit' => 'user_stories#edit'
  match 'projects/new' => 'projects#new'
  match 'projects/:id/edit' => 'projects#edit'
  match 'projects/index' => 'projects#index'
  match 'projects/get_related_pages' => 'projects#get_related_pages'
  match 'projects/:id' => 'projects#show'
  
match 'user_stories/getByProject' => 'user_stories#getByProject' 	  
resources :user_stories
  #match 'user_stories/' => 'user_stories#index'	
  #match 'user_stories/:id' => 'user_stories#show'	
  match 'comments/new' => 'comments#new'
  match 'pages/new' => 'pages#new'
  match 'states/new' => 'states#new'
  match 'user_stories/new' => 'user_stories#new'
  match 'about/' => 'about#index'

  get "home/index"

  resources :comments do
   collection do
    get 'get_by_page'
   end
  end
  
  resources :states

  resources :users do
   collection do
	get 'get_related_comments'
	get 'get_related_states'
   end
  end
  
  match 'pages/get_related_comments' => 'pages#get_related_comments'
  match 'pages/get_related_states' => 'pages#get_related_states'

  
  match 'pages/new' => 'pages#new'
  resources :pages do
   collection do
    get 'get_last_state'
   end
  end
  
  
  match 'projects/new' => 'projects#new'
  
  resources :projects do
   collection do
    get 'get_related_pages'
   end
  end

  match 'pages/:id' => 'pages#show'
  match 'states/:id' => 'states#show'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
