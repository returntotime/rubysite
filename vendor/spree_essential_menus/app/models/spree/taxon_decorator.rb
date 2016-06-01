Spree::Taxon.class_eval do

  has_many :menus
  after_save :update_link_to_menu
  after_destroy :update_menu

  def update_link_to_menu
    self.menus.update_all(:url => Spree::Core::Engine.routes.url_helpers.nested_categories_path(self.permalink))
  end

  def update_menu
    self.menus.update_all(:url => nil, :taxon_id => nil)
  end
end