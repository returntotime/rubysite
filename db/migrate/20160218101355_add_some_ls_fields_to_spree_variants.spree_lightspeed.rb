# This migration comes from spree_lightspeed (originally 20150628135904)
class AddSomeLsFieldsToSpreeVariants < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :ls_msrp, :decimal)
      add_column :spree_variants, :ls_msrp, :decimal, :precision => 8, :scale => 2
    end

    unless column_exists?(:spree_variants, :ls_length, :decimal)
      add_column :spree_variants, :ls_length, :decimal, :precision => 8, :scale => 2
    end

    unless column_exists?(:spree_variants, :ls_upc, :string)
      add_column :spree_variants, :ls_upc, :string
    end

    unless column_exists?(:spree_variants, :ls_custom_sku, :string)
      add_column :spree_variants, :ls_custom_sku, :string
    end

    unless column_exists?(:spree_variants, :ls_manufacturer_sku, :string)
      add_column :spree_variants, :ls_manufacturer_sku, :string
    end

    unless column_exists?(:spree_variants, :ls_default_cost, :decimal)
      add_column :spree_variants, :ls_default_cost, :decimal, :precision => 8, :scale => 2
    end
  end
end
