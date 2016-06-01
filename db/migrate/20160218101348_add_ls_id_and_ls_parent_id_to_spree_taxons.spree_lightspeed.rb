# This migration comes from spree_lightspeed (originally 20150519024154)
class AddLsIdAndLsParentIdToSpreeTaxons < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_taxons, :ls_id, :integer)
    add_column :spree_taxons, :ls_id, :integer
    end

    unless column_exists?(:spree_taxons, :ls_parent_id, :integer)
      add_column :spree_taxons, :ls_parent_id, :integer
    end
  end
end
