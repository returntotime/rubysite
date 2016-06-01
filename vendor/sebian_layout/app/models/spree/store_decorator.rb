module Spree
  Store.class_eval do
    has_attached_file :logo, :styles => { :thumb => "430x" },
                      # :default_url => "",
                      :url => "/uploads/:class/:id/images/:basename-:style.:extension",
                      :path => ":rails_root/public/uploads/:class/:id/images/:basename-:style.:extension",
                      :convert_options => {
                          :all => '-strip'
                      }
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

    has_attached_file :footer_logo, :styles => { :thumb => "430x" },
                      # :default_url => "",
                      :url => "/uploads/:class/:id/images/:basename-:style.:extension",
                      :path => ":rails_root/public/uploads/:class/:id/images/:basename-:style.:extension",
                      :convert_options => {
                          :all => '-strip'
                      }
    validates_attachment_content_type :footer_logo, :content_type => /\Aimage\/.*\Z/

    has_attached_file :favicon, :styles => { :thumb => "16x", :medium => "50x" },
                      :url => "/uploads/:class/:id/images/:basename-:style.:extension",
                      :path => ":rails_root/public/uploads/:class/:id/images/:basename-:style.:extension",
                      :convert_options => {
                          :all => '-strip'
                      }
    validates_attachment_content_type :favicon, :content_type => /\Aimage\/.*\Z/

    def image_url(style=:original)
      logo.present? ? logo(style) : ""
    end

    def footer_logo_url(style=:original)
      footer_logo.present? ? footer_logo(style) : ""
    end

    def favicon_url(style=:original)
      favicon.present? ? favicon(style) : ""
    end

  end
end