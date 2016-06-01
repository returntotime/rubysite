class Spree::BlogEntryBanner < Spree::Image
  has_attached_file :attachment,
                    :styles => {:normal => '848x360>'},
                    :default_style => :normal,
                    :default_url => "blog_normal.png",
                    :url => "/uploads/spree/blog_entry_banners/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/spree/blog_entry_banners/:id/:style/:basename.:extension"
end
