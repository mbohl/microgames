Microgames::Application.routes.draw do
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

  #SESSION PATHS
   match "/", :to => 'session#new', :as => :signin
   post "/sessions", :to => "session#create"
   match "/destroysession", :to => "session#destroy", :as => :signout

   #USER PATHS
   match "/signup",  :to => "users#new"
   match "/users/:id", :to => "users#show", :as => :showuser
   match "/users/:id/profile", :to => "users#view_profile", :as => :viewprofile

   #GAME PATHS
   match "/creategame", :to => "games#new", :as => :create_game
   post "/games", :to => "games#create"
   match "/showgame/:id", :to => "games#show", :as => :show_game
   match "/changegame/:game_id/:state_index", :to => "games#change_state", :as => :change_state

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
