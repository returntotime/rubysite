class AddFeaturedToSpreeTaxonomies < ActiveRecord::Migration
  def change
    add_column :spree_taxonomies, :featured, :boolean, :default => false
  end
end
