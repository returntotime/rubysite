class AddFieldOrderForSocial < ActiveRecord::Migration
  def self.up
    add_column :spree_socials, :order, :integer, default: 0
  end
  def self.down
    remove_column :spree_socials, :order
  end
end
