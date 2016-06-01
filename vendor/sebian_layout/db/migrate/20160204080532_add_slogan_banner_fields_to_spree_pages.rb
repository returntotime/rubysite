class AddSloganBannerFieldsToSpreePages < ActiveRecord::Migration
  def change
    add_attachment :spree_pages, :banner
    add_column :spree_pages, :slogan, :string
  end
end
