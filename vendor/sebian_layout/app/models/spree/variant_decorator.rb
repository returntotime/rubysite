module Spree
  Variant.class_eval do
    scope :no_out_of_stock, -> { where(out_of_stock: false) }
    scope :out_of_stock, -> { where(out_of_stock: true) }

    after_save :update_out_of_stock

    def no_out_of_stock?
      !out_of_stock
    end

    def update_out_of_stock
      if self.can_supply?
        out_of_stock = false
      else
        # Find stock items that this variant belongs to
        sub_query = self.stock_items.select(:id).to_sql
        # Group hide out of stock of the locations that the above stock items belong to
        locations_hide_out_stock = Spree::StockLocation.joins(:stock_items).where("spree_stock_items.id IN (#{sub_query})").collect(&:hide_out_of_stock).uniq

        # If all locations, that this variant belong to, have been marked hide out of stock or this variant was deleted
        # then this variant is updated to out of stock
        out_of_stock = (locations_hide_out_stock.include?(true) && locations_hide_out_stock.count == 1) || self.deleted?
      end
      self.update_column(:out_of_stock, out_of_stock)
      if self.deleted?
        self.product.reload
        self.product.master.update_column(:out_of_stock, self.product.out_of_stock?) unless self.is_master
      else
        self.product.master.update_column(:out_of_stock, out_of_stock) unless self.is_master
      end
    end
  end
end
