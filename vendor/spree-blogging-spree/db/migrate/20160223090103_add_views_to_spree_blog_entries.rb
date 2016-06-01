class AddViewsToSpreeBlogEntries < ActiveRecord::Migration
  def change
      add_column :spree_blog_entries, :views, :integer, :default => 0
  end
end
