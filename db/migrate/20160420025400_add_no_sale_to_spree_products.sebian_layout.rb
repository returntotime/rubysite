# This migration comes from sebian_layout (originally 20160420025227)
class AddNoSaleToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :no_sale, :boolean, :default => false
  end
end
