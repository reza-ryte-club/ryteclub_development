#Myapp::Application.routes.draw do

  

  

 # get 'users/index'

#  get "home/index"

Story::Application.routes.draw do

  

  resources :plotphotos

  resources :talephotos

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"} 
  get '/users', to: 'users#index'
  #get '/edit_profile', to: 'users#edit', as: 'role_edit'
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
   resources :users , only: [:edit, :update]

   resource :user, only: [:edit] do
     collection do
       patch 'update_role'
     end
   end
   resources :tales
  #resources :users, only: [:edit]

#  root 'tales#index'
  root  'tales#index'# =>, filter: "Story"
  #root 'activities#index'
  get 'tales/list', to: 'tales#tales_list'
  get "homepages/index"
  get "activities/index"
  get "journals/index"
  resources :contacts
  resources :bios
  resources :invitations
  resources :sharings
  resources :follows
 # get "users/index"
  #get "users/show"
  #get "users/sign_out"
  get "profiles/index"
  #get "users/sign_up"
  #match 'sign_up', :to => 'users#create'

  
  #devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  
  #match 'users/sign_up', controller => '/devise/registration',
  get "/pages/id", to: 'pages#show'
  resources :fruits
  
  resources :plots do
    member do
      post 'update'
    end
  end
  #devise_for :users do 
  #  get '/users/sign_out' => 'devise/sessions#destroy' 
  # end
  

  match 'featured_stories', :controller => 'tales', :action => 'featured_stories', :via => [:get]
  match 'trending_stories', :controller => 'tales', :action => 'trending_stories', :via => [:get]
  match 'tales/new',  :controller => 'tales', :action => 'new', :via => [:post]
  match 'tales/:id',  :controller => 'tales', :action => 'show', :via => [:get]
  match 'profiles/:id', :controller => 'profiles', :action => 'index', :via => [:get]
  match 'profilesOf', :controller => 'profiles', :action => 'follow', :via => [:get, :post,:delete]
  match 'profilesOfU', :controller => 'profiles', :action => 'unfollow', :via => [:get, :post,:delete]
  #match 'editPlots',  :controller => 'plots', :action => 'editPlot', :via => [:get, :post,:put,:delete]


  match 'talesOf', :controller =>  'tales', :action => 'follow', :via => [:get, :post,:delete]
  match 'talesOfU', :controller => 'tales', :action => 'unfollow', :via => [:get, :post,:delete]

  match 'likesOf', :controller => 'tales', :action => 'like', :via => [:get, :post,:delete]
  match 'likesOfU', :controller => 'tales', :action => 'unlike', :via => [:get, :post,:delete]

  
  #match 'fileview', :controller => 'boxelements', :action => 'ruin', :via => [:get, :post,:delete]
  match 'fruit',:controller => 'fruits', :action => 'ruin', :via => [:get, :post,:delete]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    #root 'homepages#index'
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
