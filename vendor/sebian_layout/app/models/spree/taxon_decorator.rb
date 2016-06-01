module Spree
  Taxon.class_eval do

    scope :enabled, -> { where(enabled: true) }
  end
end