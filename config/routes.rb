if RUBY_VERSION.include?("1.9.")
  require 'sidekiq/web'
end

Rdcms::Engine.routes.draw do
  if RUBY_VERSION.include?("1.9.")
    mount Sidekiq::Web => '/admin/background'
  end

  # post '/api/v1/tokens' => '/api/v1/tokens_controller#create'
  namespace "api" do
    namespace "v1" do
      resources :tokens, only: [:create]
    end
  end

  # get 'sitemap', :to => 'articles#sitemap', :defaults => {:format => "xml"}

  # devise_for :visitors, :controllers => { :omniauth_callbacks => "visitors/omniauth_callbacks" }
  # devise_scope :visitors do
  #   get '/visitors/auth/:provider' => 'omniauth_callbacks#passthru'
  # end

  # match "/*article_id.pdf", :to => "articles#convert_to_pdf"
  # match "/*article_id", :to => "articles#show"

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
  # root :to => 'articles#show', :defaults => {:startpage => true}

  # Ver se tem fazer isso ficar encapsulado aqui, sem a necessidade de definir em cada projeto
  # match '/admin/edit_page/:id' =>  'publications#edit_page', :as => :admin_edit_page_publication_path
end
