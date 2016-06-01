require 'acts_as_tree'
class Spree::Menu < ActiveRecord::Base
  include ActsAsTree

  # before_validation :get_static_page_path

  belongs_to :menu_bar
  belongs_to :page
  belongs_to :taxon

  # attr_accessible :page_id, :sequence,:parent_id, :link_text, :url, :visible, :menu_bar_id
  alias_attribute :position, :sequence
   # nguyen bao thi 01/03/2016

  #  has_attached_file :menu_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :menu_image, content_type: /\Aimage\/.*\Z/

  # nguyen bao thi 01/03/2016

  # do_not_validate_attachment_file_type :menu_image
  # validates_attachment_presence :menu_image


  # attr_accessible :alt, :menu_image, :vieweable

  # acts_as_tree :order => "sequence"

  #validates_presence_of :sequence
  #validates_numericality_of :sequence

  validates_presence_of :link_text
  # validates_presence_of :url
  validates_presence_of :menu_bar

  # default_scope order(:sequence)
  # scope :visible, where(:visible => true)

  before_save :check_url_with_taxon
  before_save :check_position
  scope :menu_parents, -> {where("parent_id IS NULL") }
  scope :visible, -> {where(:visible => true)}
  has_many :children, :class_name => "Spree::Menu", :foreign_key => "parent_id"

  def check_url_with_taxon
    if self.taxon.present?
      self.url = Spree::Core::Engine.routes.url_helpers.nested_categories_path(self.taxon.try(:permalink))
    end
  end

  def check_position
    unless sequence.present?
      self.sequence = 1
    end
  end

   has_attached_file :menu_image,
    :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
    :default_style => :medium,
    :url => '/spree/menus/:id/:style/:basename.:extension',
    :path => ':rails_root/public/spree/menus/:id/:style/:basename.:extension'

  def image_content?
    menu_image_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end

  def attachment_sizes
    hash = {}
    hash.merge!(:mini => '48x48>', :greyscale => {:processors => [:grayscale]}) if image_content?
    hash.merge!(:logo_color => '123x81>', :logo_grey => {:geometry => '123x81>', :processors => [:thumbnail,:grayscale]}) if parent_id.nil?
    hash
  end

  private
    def get_static_page_path
      if attribute_present?("page_id")
        self.url = self.page.path
      end
    end
end



#<Spree::Menu id: 3, page_id: nil, menu_bar_id: 1, sequence: 1, parent_id: nil, link_text: "home", url: "/", visible: true, created_at: "2016-03-02 08:16:39", updated_at: "2016-03-03 07:18:10", menu_image_file_name: nil, menu_image_content_type: nil, menu_image_file_size: nil, menu_image_updated_at: nil, taxon_id: nil>,

#<Spree::Menu id: 4, page_id: nil, menu_bar_id: 1, sequence: 2, parent_id: nil, link_text: "product", url: "/products", visible: true, created_at: "2016-03-02 08:17:15", updated_at: "2016-03-03 07:18:24", menu_image_file_name: nil, menu_image_content_type: nil, menu_image_file_size: nil, menu_image_updated_at: nil, taxon_id: nil>,
#<Spree::Menu id: 5, page_id: nil, menu_bar_id: 1, sequence: 3, parent_id: nil, link_text: "contact", url: "/contact-us", visible: true, created_at: "2016-03-02 08:17:59", updated_at: "2016-03-03 07:01:27", menu_image_file_name: nil, menu_image_content_type: nil, menu_image_file_size: nil, menu_image_updated_at: nil, taxon_id: nil>
