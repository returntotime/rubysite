# This migration comes from sebian_layout (originally 20160425110524)
class AddOutOfStockToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :out_of_stock, :boolean, :default => false
  end
end
