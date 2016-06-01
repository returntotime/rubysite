# This migration comes from sebian_layout (originally 20160411065230)
class AddFaviconToSpreeStores < ActiveRecord::Migration
  def change
    add_attachment :spree_stores, :favicon
  end
end
