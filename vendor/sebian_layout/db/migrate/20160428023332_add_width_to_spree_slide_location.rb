class AddWidthToSpreeSlideLocation < ActiveRecord::Migration
  def change
    add_column :spree_slide_locations, :width, :integer, :null => true
  end
end
