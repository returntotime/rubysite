class AddFaviconToSpreeStores < ActiveRecord::Migration
  def change
    add_attachment :spree_stores, :favicon
  end
end
