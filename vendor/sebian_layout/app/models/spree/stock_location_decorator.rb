module Spree
  StockLocation.class_eval do

    after_update :set_out_of_stock_for_variants

    # all stock locations are marked hide out of stock then the out of stock variants of them also are marked out of stock
    # if only a location is marked hide out of stock then the out of stock variants aren't marked out of stock
    def set_out_of_stock_for_variants
      # Find stock items of this stock locations
      sub_query = Spree::StockItem.where("stock_location_id = ?", self.id).select("id").to_sql
      if self.hide_out_of_stock
        # Update out of stock to variants which are in this location
        product_has_variants = Spree::Product.joins(:variants).collect(&:id).uniq
        product_no_variants = Spree::Product.where("id NOT IN (?)", product_has_variants).group("id").select("id").to_sql
        Spree::Variant.joins(:stock_items).where("
          spree_stock_items.count_on_hand <= 0
          and spree_stock_items.id IN (#{sub_query})
          and (
            spree_stock_items.backorderable = false
            or (
              spree_variants.is_master = true
              and (
                spree_variants.product_id IN (?)
                or
                spree_variants.product_id IN (#{product_no_variants})
              )
            )
          )", product_has_variants).update_all(:out_of_stock => true)

        # If the above variants also are in locations what are not marked hide out of stock, they should be updated non out of stock again
        # Find the non hide out of stock locations that the above variants aren't in them
        sub_query = Spree::StockItem.joins(:stock_location).where("spree_stock_items.stock_location_id != ? and spree_stock_locations.hide_out_of_stock = ?", self.id, false).select("spree_stock_items.id").to_sql
        Spree::Variant.joins(:stock_items).where("spree_stock_items.count_on_hand <= 0 and spree_stock_items.id IN (#{sub_query}) and (spree_stock_items.backorderable = false or (spree_variants.is_master = true and spree_variants.product_id IN (?)))", product_has_variants).update_all(:out_of_stock => false)
      else
        Spree::Variant.joins(:stock_items).where("spree_stock_items.id IN (#{sub_query})").update_all(:out_of_stock => false)
      end
    end
  end
end