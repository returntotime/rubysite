# This migration comes from sebian_layout (originally 20160428023332)
class AddWidthToSpreeSlideLocation < ActiveRecord::Migration
  def change
    add_column :spree_slide_locations, :width, :integer, :null => true
  end
end
