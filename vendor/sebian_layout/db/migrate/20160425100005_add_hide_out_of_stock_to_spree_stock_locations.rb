class AddHideOutOfStockToSpreeStockLocations < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :hide_out_of_stock, :boolean, :default => false
  end
end
