class AddShowBannerToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :show_banner, :boolean, :default => true
  end
end
