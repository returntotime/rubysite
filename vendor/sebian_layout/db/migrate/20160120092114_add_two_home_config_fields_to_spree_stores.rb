class AddTwoHomeConfigFieldsToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :show_new_collection,      :boolean, default: true
    add_column :spree_stores, :show_testimonial,         :boolean, default: true
  end
end
