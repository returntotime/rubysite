# This migration comes from spree_blogging_spree (originally 20160218105021)
class AddTaggingsCounterCacheToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :taggings_count, :integer, default: 0
  end

  def self.down
    remove_column :tags, :taggings_count
  end
end