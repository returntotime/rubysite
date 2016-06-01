class AddUseSpeedToSpreeSlideLocation < ActiveRecord::Migration
  def change
    add_column :spree_slide_locations, :use_speed, :boolean, :default => false
  end
end
