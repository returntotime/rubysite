# This migration comes from sebian_layout (originally 20160421091319)
class AddUseLargeBannerToSpreeBlogEntries < ActiveRecord::Migration
  def change
    add_column :spree_blog_entries, :use_large_banner, :boolean, :default => true
  end
end
