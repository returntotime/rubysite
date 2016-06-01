# This migration comes from sebian_layout (originally 20160120092114)
class AddTwoHomeConfigFieldsToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :show_new_collection,      :boolean, default: true
    add_column :spree_stores, :show_testimonial,         :boolean, default: true
  end
end
