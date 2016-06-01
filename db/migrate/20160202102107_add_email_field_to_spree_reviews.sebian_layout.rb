# This migration comes from sebian_layout (originally 20160202101734)
class AddEmailFieldToSpreeReviews < ActiveRecord::Migration
  def change
    add_column :spree_reviews, :email, :string
  end
end
