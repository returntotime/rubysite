# This migration comes from sebian_layout (originally 20160325072135)
class AddDelayToSpreeSlideSlideLocations < ActiveRecord::Migration
  def change
    add_column :spree_slide_slide_locations, :delay, :integer, :null => true
  end
end
