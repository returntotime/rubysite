class AddSomeOptionFieldsToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :in_new_arrival, :boolean, :default => false
    add_column :spree_products, :in_in_this_look, :boolean, :default => false
    add_column :spree_products, :in_popular_weekly, :boolean, :default => false
  end
end
