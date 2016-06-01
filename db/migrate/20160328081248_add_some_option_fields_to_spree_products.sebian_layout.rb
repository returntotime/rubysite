# This migration comes from sebian_layout (originally 20160328080820)
class AddSomeOptionFieldsToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :in_new_arrival, :boolean, :default => false
    add_column :spree_products, :in_in_this_look, :boolean, :default => false
    add_column :spree_products, :in_popular_weekly, :boolean, :default => false
  end
end
