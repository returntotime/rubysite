class AddNoSaleToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :no_sale, :boolean, :default => false
  end
end
