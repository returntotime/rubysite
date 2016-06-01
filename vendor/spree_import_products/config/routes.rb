Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
      resources :product_imports, :only => [:index, :new, :create, :generate_to_csv]
  end
end
