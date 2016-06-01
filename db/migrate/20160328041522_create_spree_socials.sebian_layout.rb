# This migration comes from sebian_layout (originally 20160328031851)
class CreateSpreeSocials < ActiveRecord::Migration
  def change
    create_table :spree_socials do |t|
      t.string :name
      t.string :url
      t.attachment :icon

      t.timestamps null: false
    end
  end
end
