module Spree
  module Admin
    GeneralSettingsController.class_eval do
      def edit
        @preferences_security = []
      end
    end
  end
end