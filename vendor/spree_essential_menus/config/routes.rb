Rails.application.routes.draw do
  Spree::Core::Engine.add_routes do
    namespace :admin do
      resources :menu_bars do
        resources :menus do
          collection do
            post :update_positions
          end
        end
      end
    end
  end
end