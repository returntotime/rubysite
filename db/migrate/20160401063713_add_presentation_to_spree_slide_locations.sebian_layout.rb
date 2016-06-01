# This migration comes from sebian_layout (originally 20160401063520)
class AddPresentationToSpreeSlideLocations < ActiveRecord::Migration
  def change
    add_column :spree_slide_locations, :presentation, :string
  end
end
