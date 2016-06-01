class Spree::BlogEntryLargeBanner < Spree::Image
  has_attached_file :attachment,
                    :styles => {:large => '1170x550>'},
                    :default_style => :large,
                    :default_url => "blog-detail-1.jpg",
                    :url => "/uploads/spree/blog_entry_large_banners/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/spree/blog_entry_large_banners/:id/:style/:basename.:extension"
end
