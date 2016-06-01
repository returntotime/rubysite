Spree::Page.class_eval do
  has_attached_file :banner,
                    url: '/spree/pages/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/pages/:id/:style/:basename.:extension',
                    default_url: "about-img.jpg",
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
  validates_attachment :banner, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}

end
