# This migration comes from spree_lightspeed (originally 20151102170602)
class AddLocalMerchantKeyAndShippingSpeedToSpreeVarians < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :local_merchant_key, :string)
      add_column :spree_variants, :local_merchant_key, :string
    end

    unless column_exists?(:spree_variants, :shipping_speed, :string)
      add_column :spree_variants, :shipping_speed, :string
    end
  end
end
