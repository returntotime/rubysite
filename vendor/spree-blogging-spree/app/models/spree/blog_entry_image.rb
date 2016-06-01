class Spree::BlogEntryImage < Spree::Image
  has_attached_file :attachment, 
     :styles => {:mini => '70x70#', :normal => '370x320>', :large => '600x600>'},
     :default_style => :large,
     :url => "/uploads/spree/blog_entry_images/:id/:style/:basename.:extension",
     :path => ":rails_root/public/uploads/spree/blog_entry_images/:id/:style/:basename.:extension"
end
