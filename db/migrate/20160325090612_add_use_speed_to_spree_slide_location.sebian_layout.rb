# This migration comes from sebian_layout (originally 20160325071944)
class AddUseSpeedToSpreeSlideLocation < ActiveRecord::Migration
  def change
    add_column :spree_slide_locations, :use_speed, :boolean, :default => false
  end
end
