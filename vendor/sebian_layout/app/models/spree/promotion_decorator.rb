module Spree
  Promotion.class_eval do
    before_validation :check_advertise
    before_update :check_all_advertise

    private

    def check_all_advertise
      if self.advertise && Promotion.advertised.count > 0
        Promotion.update_all(:advertise => 0)
      end
    end

    def check_advertise
      if self.new_record? && self.advertise && Promotion.advertised.count > 0
        errors["promotion.advertised"] = "can't create greater 1 advertised promotion"
      end
    end
  end
end