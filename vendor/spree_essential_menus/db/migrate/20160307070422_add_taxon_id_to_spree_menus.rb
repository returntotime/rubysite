class AddTaxonIdToSpreeMenus < ActiveRecord::Migration
  def change
    add_column :spree_menus, :taxon_id, :integer
  end
end
