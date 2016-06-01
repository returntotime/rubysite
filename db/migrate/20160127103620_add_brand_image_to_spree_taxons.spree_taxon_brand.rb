# This migration comes from spree_taxon_brand (originally 20151201103946)
class AddBrandImageToSpreeTaxons < ActiveRecord::Migration
  def change
    add_attachment :spree_taxons, :brand_image
  end
end
