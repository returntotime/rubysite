Spree::SlideLocation.class_eval do
  has_many :slide_slide_locations, :dependent => :destroy

  validates :height, numericality: { only_integer: true }, :allow_blank => true
  validates :width, numericality: { only_integer: true }, :allow_blank => true

  scope :fullwidth?, -> {where(:fullwidth => true)}

  after_save :check_delay

  def check_delay
    unless self.use_speed
      self.slide_slide_locations.update_all(:delay => nil,:animation => nil)
    else
      self.slide_slide_locations.update_all(:delay => 10000, :animation => "random")
    end
  end
end