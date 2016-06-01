Spree::Slide.class_eval do
  has_many :slide_slide_locations, :dependent => :destroy

  accepts_nested_attributes_for :slide_slide_locations
end