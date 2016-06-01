# This migration comes from sebian_layout (originally 20160425100005)
class AddHideOutOfStockToSpreeStockLocations < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :hide_out_of_stock, :boolean, :default => false
  end
end
