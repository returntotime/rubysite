# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create store
preference_store = Spree::Preferences::Store.instance
if store = Spree::Store.where(default: true).first
  store.meta_description = preference_store.get('spree/app_configuration/default_meta_description') {}
  store.meta_keywords    = preference_store.get('spree/app_configuration/default_meta_keywords') {}
  store.seo_title        = preference_store.get('spree/app_configuration/default_seo_title') {}
  store.save!
else
  # we set defaults for the things we now require
  Spree::Store.new do |s|
    s.name              = preference_store.get 'spree/app_configuration/site_name' do
      'Spree Demo Site'
    end
    s.url               = preference_store.get 'spree/app_configuration/site_url' do
      'demo.spreecommerce.com'
    end
    s.mail_from_address = preference_store.get 'spree/app_configuration/mails_from' do
      'spree@example.com'
    end

    s.meta_description = preference_store.get('spree/app_configuration/default_meta_description') {}
    s.meta_keywords    = preference_store.get('spree/app_configuration/default_meta_keywords') {}
    s.seo_title        = preference_store.get('spree/app_configuration/default_seo_title') {}
    s.default_currency = preference_store.get('spree/app_configuration/currency') {}
    s.code             = 'spree'
  end.save!
end

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)


list_locations=[
    { :name => 'home_slider'},
    { :name => 'home_our_story_background'},
    { :name => 'testimonial_background'},
    { :name => "home_subcribe_background"}
]
list_locations.each do |location|
  Spree::SlideLocation.find_or_create_by(name: location[:name]) do |l|
    l.name = location[:name]
  end
end

list_pages=[
    { :title => 'ABOUT US',:body => "ABOUT US CONTENT IS UPDATING",:slug=>"about-us",:visible=>1},
    { :title => 'DELIVERY INFOMATION',:body => "DELIVERY INFOMATION CONTENT IS UPDATING",:slug=>"delivery-infomation",:visible=>1},
    { :title => 'PRIVACY & POLICY',:body => "PRIVACY & POLICY CONTENT IS UPDATING",:slug=>"privacy-policy",:visible=>1},
    { :title => 'TEMRS & CONDITIONS',:body => "TEMRS & CONDITIONS CONTENT IS UPDATING",:slug=>"term-conditions",:visible=>1},
    { :title => 'MANUFACTURES',:body => "MANUFACTURES CONTENT IS UPDATING",:slug=>"manufactures",:visible=>1}
]
list_pages.each do |page|
  @store=Spree::Store.first
  unless page[:slug].start_with? "/"
    page[:slug] = "/" + page[:slug]
  end
  @page=Spree::Page.find_or_create_by(slug: page[:slug]) do |p|
    p.title = page[:title]
    p.slug  = page[:slug]
    p.body  = page[:body]
    p.visible = page[:visible]
  end
  unless @store.nil?
    @page.store_ids = [@store.id]
  end
end