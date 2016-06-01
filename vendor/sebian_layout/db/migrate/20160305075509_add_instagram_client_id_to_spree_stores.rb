class AddInstagramClientIdToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :instagram_client_id, :string
  end
end
