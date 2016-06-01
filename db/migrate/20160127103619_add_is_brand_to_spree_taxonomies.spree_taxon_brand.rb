# This migration comes from spree_taxon_brand (originally 20151201101018)
class AddIsBrandToSpreeTaxonomies < ActiveRecord::Migration
  def change
    add_column :spree_taxonomies, :is_brand, :boolean, :default => false
  end
end
