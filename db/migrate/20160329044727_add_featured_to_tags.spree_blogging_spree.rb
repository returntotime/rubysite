# This migration comes from spree_blogging_spree (originally 20160329044314)
class AddFeaturedToTags < ActiveRecord::Migration
  def change
    add_column :tags, :featured, :boolean, :default => false
  end
end
