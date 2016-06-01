# This migration comes from spree_lightspeed (originally 20150615085950)
class AddEnabledToSpreeVariants < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :enabled, :boolean)
      add_column :spree_variants, :enabled, :boolean, :default => true
    end
  end
end
