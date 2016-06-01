Spree::Product.class_eval do

  def can_supply?
    count = 0
    if self.variants.count > 0
      self.variants_and_option_values(Spree::Config[:currency]).each do |variant|
        if variant.can_supply? && variant.enabled
          count = count + 1
        end
      end
    elsif self.master.can_supply?
      count = 1
    end
    count > 0
  end

  def out_of_stock?
    self.variants.count > 0 ? self.variants.out_of_stock.count == self.variants.count : self.master.out_of_stock
  end

  scope :in_this_look, -> { where(in_in_this_look: true) }
  scope :new_arrival, -> { where(in_new_arrival: true) }
  scope :popular_weekly, -> { where(in_popular_weekly: true) }
  scope :no_sale, -> { where(no_sale: true) }

  def variants_and_option_values(current_currency = nil)
    variants.enabled.includes(:option_values).active(current_currency).select do |variant|
      variant.option_values.any?
    end
  end

end