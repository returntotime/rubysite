# This migration comes from sebian_layout (originally 20160331112424)
class AddExtenalLinkToSpreeTaxons < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :extenal_link, :string
  end
end
