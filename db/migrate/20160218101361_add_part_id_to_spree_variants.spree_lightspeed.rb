# This migration comes from spree_lightspeed (originally 20160215064254)
class AddPartIdToSpreeVariants < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :part_id, :integer)
      add_column :spree_variants, :part_id, :integer
    end
  end
end
