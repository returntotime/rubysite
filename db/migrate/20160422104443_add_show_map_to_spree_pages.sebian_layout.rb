# This migration comes from sebian_layout (originally 20160422104223)
class AddShowMapToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :show_map, :boolean, :default => false
  end
end
