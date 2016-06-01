# This migration comes from spree_lightspeed (originally 20160502033142)
class AddFromLsToSpreeOptionTypes < ActiveRecord::Migration
  def up
    unless column_exists?(:spree_option_types, :from_ls, :boolean)
      add_column :spree_option_types, :from_ls, :boolean, :default => false
    end
  end

  def down
    if column_exists?(:spree_option_types, :from_ls, :boolean)
      remove_column :spree_option_types, :from_ls
    end
  end
end
