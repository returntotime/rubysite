Spree::ReviewsController.class_eval do
  def permitted_review_attributes
    [:rating, :title, :review, :name, :email,:show_identifier]
  end
end