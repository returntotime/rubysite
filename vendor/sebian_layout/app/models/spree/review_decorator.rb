Spree::Review.class_eval do

  validates :email, presence: true, email: true

  def posted_date
    created_at.strftime('%b %d, %Y')
  end

end