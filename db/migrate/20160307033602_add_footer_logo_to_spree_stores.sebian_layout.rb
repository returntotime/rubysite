# This migration comes from sebian_layout (originally 20160307033442)
class AddFooterLogoToSpreeStores < ActiveRecord::Migration
  def change
    add_attachment :spree_stores, :footer_logo
  end
end
