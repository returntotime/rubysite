# This migration comes from spree_lightspeed (originally 20150908101438)
class AddLocalMerchantIdToSpreeVariants < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :local_merchant_id, :integer)
      add_column :spree_variants, :local_merchant_id, :integer
    end
  end
end
