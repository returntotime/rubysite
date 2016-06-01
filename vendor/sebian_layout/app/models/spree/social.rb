class Spree::Social < ActiveRecord::Base
  validates :name, presence: true
  validates :url, presence: true
  validates_numericality_of :order, only_integer: true

  has_attached_file :icon,
                    styles: { mini: '25x25>', large: '100x100>'},
                    default_style: :large,
                    url: '/spree/icon/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/icon/:id/:style/:basename.:extension',
                    # convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
                    convert_options: { all: '-strip -auto-orient' } # Fix for darker image on LS3

  validates_attachment :icon,
                       :presence => true,
                       :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }
end
