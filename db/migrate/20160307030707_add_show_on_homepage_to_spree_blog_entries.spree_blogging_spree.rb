# This migration comes from spree_blogging_spree (originally 20160307030443)
class AddShowOnHomepageToSpreeBlogEntries < ActiveRecord::Migration
  def change
    add_column :spree_blog_entries, :show_on_homepage, :boolean, :default => false
  end
end
