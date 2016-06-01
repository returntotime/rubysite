# This migration comes from spree_lightspeed (originally 20150601082134)
class AddLsNameLsIdAndLsMatrixIdToSpreeVariants < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :ls_name, :integer)
      add_column :spree_variants, :ls_name, :string
    end

    unless column_exists?(:spree_variants, :ls_id, :integer)
      add_column :spree_variants, :ls_id, :integer
    end

    unless column_exists?(:spree_variants, :ls_matrix_id, :integer)
      add_column :spree_variants, :ls_matrix_id, :integer
    end
  end
end
