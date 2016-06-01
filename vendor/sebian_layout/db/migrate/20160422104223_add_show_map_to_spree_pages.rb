class AddShowMapToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :show_map, :boolean, :default => false
  end
end
