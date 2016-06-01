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
