# This migration comes from spree_taxon_image (originally 20151201064242)
class AddImageAndBannerToSpreeTaxons < ActiveRecord::Migration
  def change
    add_attachment :spree_taxons, :image
    add_attachment :spree_taxons, :banner
  end
end
