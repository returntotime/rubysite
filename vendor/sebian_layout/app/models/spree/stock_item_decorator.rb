module Spree
  StockItem.class_eval do
    after_save :update_variant_out_of_stock

    def update_variant_out_of_stock
      self.variant.update_out_of_stock
    end
  end
end