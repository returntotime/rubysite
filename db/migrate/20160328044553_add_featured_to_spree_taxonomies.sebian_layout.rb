# This migration comes from sebian_layout (originally 20160328044420)
class AddFeaturedToSpreeTaxonomies < ActiveRecord::Migration
  def change
    add_column :spree_taxonomies, :featured, :boolean, :default => false
  end
end
