# This migration comes from spree_lightspeed (originally 20150424070153)
class CreateSpreeBrands < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'spree_brands'
      create_table :spree_brands do |t|
        t.string :name
        t.attachment :logo_footer
        t.attachment :logo_header
        t.integer :position
        t.string :slug

        t.timestamps null: false
      end
    end
  end
end
