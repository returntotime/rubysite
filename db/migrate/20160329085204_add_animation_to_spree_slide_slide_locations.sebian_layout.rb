# This migration comes from sebian_layout (originally 20160329085103)
class AddAnimationToSpreeSlideSlideLocations < ActiveRecord::Migration
  def change
    add_column :spree_slide_slide_locations, :animation, :string, :null => true
  end
end
