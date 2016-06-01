# This migration comes from spree_lightspeed (originally 20150519095133)
class AddLsIdToSpreeBrands < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_brands, :ls_id, :integer)
      add_column :spree_brands, :ls_id, :integer, :after => :slug
    end
  end
end
