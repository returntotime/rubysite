module Spree
  module ContactUs
    Contact.class_eval do

      attr_accessor :email, :message, :name, :subject, :website

      def initialize(attributes = {})
        [:email, :website, :message, :name, :subject].each do |attribute|
          self.send("#{attribute}=", attributes[attribute]) if attributes and attributes.has_key?(attribute)
        end
      end

      def save
        if self.valid?
          Spree::ContactUs::ContactMailer.contact_email(self).deliver
          return true
        end
        return false
      end

      def persisted?
        false
      end

    end
  end
end
