# This migration comes from spree_lightspeed (originally 20160423073146)
class AddLsIdToSpreeTaxCategories < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_tax_categories, :ls_id, :integer)
      add_column :spree_tax_categories, :ls_id, :integer
    end
  end
end
