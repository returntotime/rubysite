# This migration comes from spree_lightspeed (originally 20150908103814)
class AddLocalMerchantIdToLineItems < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_line_items, :local_merchant_id, :integer)
      add_column :spree_line_items, :local_merchant_id, :integer
    end
  end
end
