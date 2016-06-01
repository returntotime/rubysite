class AddAnimationToSpreeSlideSlideLocations < ActiveRecord::Migration
  def change
    add_column :spree_slide_slide_locations, :animation, :string, :null => true
  end
end
