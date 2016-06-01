# This migration comes from sebian_layout (originally 20160411074557)
class AddShowBannerToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :show_banner, :boolean, :default => true
  end
end
