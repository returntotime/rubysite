module Spree
  module Admin
    class HomeSettingsController < Spree::Admin::BaseController

      def update
        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        flash[:success] = Spree.t(:your_setting_has_been_updated)
        return redirect_to :back
      end
    end
  end
end
