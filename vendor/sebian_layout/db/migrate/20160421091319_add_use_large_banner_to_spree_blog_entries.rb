class AddUseLargeBannerToSpreeBlogEntries < ActiveRecord::Migration
  def change
    add_column :spree_blog_entries, :use_large_banner, :boolean, :default => true
  end
end
