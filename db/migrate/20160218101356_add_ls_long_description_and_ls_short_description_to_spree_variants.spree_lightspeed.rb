# This migration comes from spree_lightspeed (originally 20150629061742)
class AddLsLongDescriptionAndLsShortDescriptionToSpreeVariants < ActiveRecord::Migration
  def change
    unless column_exists?(:spree_variants, :ls_long_description, :text)
      add_column :spree_variants, :ls_long_description, :text, :limit => 4294967295
    end

    unless column_exists?(:spree_variants, :ls_short_description, :text)
      add_column :spree_variants, :ls_short_description, :text, :limit => 4294967295
    end
  end
end
