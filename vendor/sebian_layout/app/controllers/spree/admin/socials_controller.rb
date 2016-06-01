module Spree
  module Admin
    class SocialsController < ResourceController

      def collection
        super.order(:name)
      end
    end
  end
end