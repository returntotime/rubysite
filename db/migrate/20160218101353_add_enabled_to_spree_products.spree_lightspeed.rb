# This migration comes from spree_lightspeed (originally 20150615085942)
class AddEnabledToSpreeProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_products, :enabled, :boolean)
      add_column :spree_products, :enabled, :boolean, :default => true
    end
  end
end
