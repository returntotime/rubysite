# This migration comes from sebian_layout (originally 20160414035834)
class AddFirstnameLastnameToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :firstname, :string
    add_column :spree_users, :lastname, :string
  end
end
