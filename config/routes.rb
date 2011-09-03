Tweetflick::Application.routes.draw do

# Twitter Authentication routes
match "/auth/:provider/callback" => "sessions#create"
match '/auth/failure' => 'sessions#failure'
match "/signout" => "sessions#destroy", :as => :signout
match '/signin' => 'sessions#new', :as => :signin
# Home Page
get "home/index"
# About Page
get "home/about"
#Sitemap
match "/sitemap" => "sitemap#index"
#Interactions
match '/interact' => "interact#index", :as => 'interact'
#Profile page
match "/:name" => "celebs#profile", :as => 'profile'



#default url
root:to=>"home#index"


  resources :tweets,:only => [] do
collection do
get 'feed/:time',:action=>'feed',:as => 'feed'
get 'fanfeed/:time',:action=>'fanfeed',:as => 'fanfeed'
get 'latest/:time(/:id)',:action=>'latest',:as => 'latest'
get 'archive/:time(/:name)',:action=>'archive',:as => 'archive'
post 'retweet/:id',:action=>'retweet',:as => 'retweet'
post 'follow/:id',:action=>'follow',:as => 'follow'
post 'reply/:id',:action=>'reply',:as => 'reply'
    end
  end
  resources :celebs,:only => [:show] do
  collection do
get 'top/:count',:action=>'top'
get 'search/:name',:action=>'search',:as => 'search'
get 'list', :action => 'list', :as => 'list'
get 'feed/:id/:time',:action=>'feed',:as => 'feed'
    end
end
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
