# This migration comes from sebian_layout (originally 20160120112822)
class AddLogoFieldToSpreeStores < ActiveRecord::Migration
  def change
    add_attachment :spree_stores, :logo
  end
end
