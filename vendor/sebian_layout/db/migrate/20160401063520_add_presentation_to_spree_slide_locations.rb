class AddPresentationToSpreeSlideLocations < ActiveRecord::Migration
  def change
    add_column :spree_slide_locations, :presentation, :string
  end
end
