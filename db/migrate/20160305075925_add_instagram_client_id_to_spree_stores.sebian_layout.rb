# This migration comes from sebian_layout (originally 20160305075509)
class AddInstagramClientIdToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :instagram_client_id, :string
  end
end
