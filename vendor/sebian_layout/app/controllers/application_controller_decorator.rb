ApplicationController.class_eval do
  before_action :load_main_nav_taxonomies
  before_filter :get_menu_bar
  before_filter :get_instagram_client
  before_filter :get_tweeter_client
  before_filter :get_freeship_promotion
  before_filter :get_social

  def load_main_nav_taxonomies
    @main_nav_taxonomies = Spree::Taxonomy.includes(root: :children).limit(4)
  end

  def get_menu_bar
    @menu_bar = Spree::MenuBar.find_by_name("main_menu")
  end

  def get_instagram_client
    @instagram_client_id = current_store.instagram_client_id
  end

  def get_tweeter_client
    # Rails.cache.clear
    @tweeter_post = Rails.cache.fetch("tweeter_post", :expires_in => 12.hours) do
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "xPjxuw2AhP2LL5iGyBuv4IDae"
        config.consumer_secret     = "uVLsxeq4VOhy2b5pxDRl72DPBrUHOu96WOHDAdukfsEwO8h24Z"
        config.access_token        = "64214968-8U7J7N8KI0FKJr85FxCfHEQTOxq02daUShescC2Va"
        config.access_token_secret = "XMrniiGZ3ndUnk7SVbs8os43iwnbq8NWYwesBzgpVTKw2"
      end
      client.user_timeline(client, options = {:count => 1}).first
    end
  end

  def get_freeship_promotion
    @top_promotion = Spree::Promotion.advertised.coupons.active.first
  end

  def get_social
    @socials = Spree::Social.order(:order)
  end
end

