module Spree
  module NewsletterHelper

    def newsletter_types
      newsletter_types = SebianLayoutConstant::NEWSLETTER_TRIGGERS.map do |k, v|
        [k, v]
      end
      options_from_collection_for_select(newsletter_types, :first, :last, Spree::Config[:newsletter_type])
    end

    def newsletter_animations
      newsletter_animations = SebianLayoutConstant::NEWSLETTER_ANIMATIONS.map do |k, v|
        [k, v]
      end
      options_from_collection_for_select(newsletter_animations, :first, :last, Spree::Config[:newsletter_animation])
    end
  end
end