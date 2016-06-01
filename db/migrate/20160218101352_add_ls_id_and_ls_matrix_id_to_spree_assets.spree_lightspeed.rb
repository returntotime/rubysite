# This migration comes from spree_lightspeed (originally 20150601082426)
class AddLsIdAndLsMatrixIdToSpreeAssets < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_assets, :ls_id, :integer)
      add_column :spree_assets, :ls_id, :integer
    end

    unless column_exists?(:spree_assets, :ls_matrix_id, :integer)
      add_column :spree_assets, :ls_matrix_id, :integer
    end
  end
end
