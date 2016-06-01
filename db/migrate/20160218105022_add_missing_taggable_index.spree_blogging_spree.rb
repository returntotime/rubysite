# This migration comes from spree_blogging_spree (originally 20160218105022)
class AddMissingTaggableIndex < ActiveRecord::Migration
  def self.up
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    remove_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end