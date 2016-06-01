# This migration comes from sebian_layout (originally 20160204080532)
class AddSloganBannerFieldsToSpreePages < ActiveRecord::Migration
  def change
    add_attachment :spree_pages, :banner
    add_column :spree_pages, :slogan, :string
  end
end
