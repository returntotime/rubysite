# This migration comes from spree_lightspeed (originally 20150424083632)
class AddBrandIdToSpreeProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_products, :brand_id, :integer)
      add_column :spree_products, :brand_id, :integer
    end
  end
end
