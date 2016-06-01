class Spree::Admin::MenuBarsController < Spree::Admin::ResourceController
  def index
  end
  def new
    @menu_bar = Spree::MenuBar.new
  end
end