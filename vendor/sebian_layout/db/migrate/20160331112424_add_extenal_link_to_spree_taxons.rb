class AddExtenalLinkToSpreeTaxons < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :extenal_link, :string
  end
end
