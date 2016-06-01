# This migration comes from spree_lightspeed (originally 20150527094235)
class AddLsIdAndLsMatrixIdToSpreeProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_products, :ls_id, :integer)
      add_column :spree_products, :ls_id, :integer
    end

    unless column_exists?(:spree_products, :ls_matrix_id, :integer)
      add_column :spree_products, :ls_matrix_id, :integer
    end
  end
end
