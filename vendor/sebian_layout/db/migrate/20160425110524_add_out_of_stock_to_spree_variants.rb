class AddOutOfStockToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :out_of_stock, :boolean, :default => false
  end
end
