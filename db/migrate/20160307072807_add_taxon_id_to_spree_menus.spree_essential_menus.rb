# This migration comes from spree_essential_menus (originally 20160307070422)
class AddTaxonIdToSpreeMenus < ActiveRecord::Migration
  def change
    add_column :spree_menus, :taxon_id, :integer
  end
end
