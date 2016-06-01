# This migration comes from spree_lightspeed (originally 20150630043856)
class AddSomeFieldsToSpreeProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_products, :ls_long_description, :text)
      add_column :spree_products, :ls_long_description, :text, :limit => 4294967295
    end

    unless column_exists?(:spree_products, :ls_short_description, :text)
      add_column :spree_products, :ls_short_description, :text, :limit => 4294967295
    end

    unless column_exists?(:spree_products, :ls_width, :decimal)
      add_column :spree_products, :ls_width, :decimal, :precision => 8, :scale => 2
    end

    unless column_exists?(:spree_products, :ls_height, :decimal)
      add_column :spree_products, :ls_height, :decimal, :precision => 8, :scale => 2
    end

    unless column_exists?(:spree_products, :ls_weight, :decimal)
      add_column :spree_products, :ls_weight, :decimal, :precision => 8, :scale => 2
    end

    unless column_exists?(:spree_products, :ls_length, :decimal)
      add_column :spree_products, :ls_length, :decimal, :precision => 8, :scale => 2
    end
  end
end
