Spree::Wishlist.class_eval do
  scope :publish, ->{where(:is_private => false)}
end