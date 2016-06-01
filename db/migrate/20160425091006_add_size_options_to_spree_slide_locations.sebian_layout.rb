# This migration comes from sebian_layout (originally 20160425043045)
class AddSizeOptionsToSpreeSlideLocations < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_slide_locations, :fullwidth, :boolean)
      add_column :spree_slide_locations, :fullwidth, :boolean, :default => true
    end

    unless column_exists?(:spree_slide_locations, :height, :integer)
      add_column :spree_slide_locations, :height, :integer, :null => true
    end
  end
end
