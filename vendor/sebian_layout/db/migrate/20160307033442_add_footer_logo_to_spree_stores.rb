class AddFooterLogoToSpreeStores < ActiveRecord::Migration
  def change
    add_attachment :spree_stores, :footer_logo
  end
end
