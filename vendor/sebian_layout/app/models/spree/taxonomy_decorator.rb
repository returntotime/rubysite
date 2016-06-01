module Spree
  Taxonomy.class_eval do

    scope :featured, -> { where(featured: true) }
    scope :unfeatured, -> { where(featured: false) }
    def featured!
      self.update_attribute(:featured, true)
    end

    def unfeatured!
      self.update_attribute(:featured, false)
    end
  end
end