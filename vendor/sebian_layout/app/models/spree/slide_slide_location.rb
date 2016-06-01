class Spree::SlideSlideLocation < ActiveRecord::Base
  belongs_to :slide
  belongs_to :slide_location

end
