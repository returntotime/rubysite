class AddEmailFieldToSpreeReviews < ActiveRecord::Migration
  def change
    add_column :spree_reviews, :email, :string
  end
end
