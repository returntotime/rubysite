Spree::Core::Engine.add_routes do
  post "/subscribe" => "home#subscribe"
  match "/express_paypal" => "paypal#express", as: :express_paypal, via: [:get, :post]

  namespace :admin do
    resource :home_settings, only: [:edit, :update]
    resources :socials
    resource :newsletters do
      collection do
        get :auth
      end
    end
    resources :taxonomies do
      member do
        post :toggle_featured
      end
    end
    resources :products do
      member do
        post :update_options
      end
    end
    resources :pages do
      member do
        post :update_options
      end
    end
    get '/admin/license-agreements/index' => 'license_agreements#index'
  end
  get '/category/*id', :to => 'taxons#show', :as => :nested_categories

  get '/products/get_options', :to => 'products#get_options'

  resources :wishlists do
    collection do
      get :wishlist_options
      get :find_wishlists
    end
  end

  get '/checkout/get_order_summary', :to => 'checkout#get_order_summary'
  get '/checkout/get_shipment_form', :to => 'checkout#get_shipment_form'
  get '/checkout/get_address_form', :to => 'checkout#get_address_form'
end
