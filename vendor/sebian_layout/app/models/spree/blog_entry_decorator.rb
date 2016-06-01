Spree::BlogEntry.class_eval do
  scope :use_large_banner?, -> {where(:use_large_banner => true)}
end