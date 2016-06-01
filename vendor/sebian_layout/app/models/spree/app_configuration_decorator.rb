require "spree/core/search/base"
module Spree
  AppConfiguration.class_eval do
    preference :copyright, :string, default: ''
    preference :footer_tagline, :string, default: ''
    preference :in_this_look, :string, default: ''
    preference :in_this_look_subtext, :string, default: ''
    preference :popular_weekly, :string, default: ''
    preference :popular_weekly_subtext, :string, default: ''
    preference :new_arrival, :string, default: ''
    preference :new_arrival_subtext, :string, default: ''
    preference :featured_designers, :string, default: ''
    preference :featured_designers_subtext, :string, default: ''
    preference :our_brands, :string, default: ''
    preference :our_brands_subtext, :string, default: ''
    preference :contact_location, :string, default: ''
    preference :contact_phone, :string, default: ''
    preference :contact_email, :string, default: ''
    preference :contact_skype, :string, default: ''
    preference :contact_open_time, :string, default: ''
    preference :title_footer_column_1, :string, default: ''
    preference :title_footer_column_2, :string, default: ''
    preference :title_footer_column_3, :string, default: ''
    preference :blog_title, :string, default: ''
    preference :the_blog, :string, default: ''
    preference :the_blog_subtext, :string, default: ''
    preference :instagram, :string, default: ''
    preference :instagram_subtext, :string, default: ''
    preference :instagram_tagline, :string, default: ''
    preference :related_product_section_title, :string, default: ''
    preference :related_product_section_tagline, :string, default: ''

    preference :show_slider, :boolean, default: true
    preference :show_in_this_look, :boolean, default: true
    preference :show_3_boxes, :boolean, default: true
    preference :show_new_arrival, :boolean, default: true
    preference :show_popular_weekly, :boolean, default: true
    preference :show_blog, :boolean, default: true
    preference :show_what_designer_says, :boolean, default: true
    preference :show_instagram_photos, :boolean, default: true
    preference :show_featured_designers, :boolean, default: true
    preference :show_our_brands, :boolean, default: true
    preference :show_loading_screen, :boolean, default: true
    preference :show_instagram_photos_footer, :boolean, default: false
    preference :show_breadcrumb_in_entire_blog, :boolean, default: true

    preference :enable_newsletter_popup, :boolean, default: true
    preference :newsletter_success_message, :string, default: 'Thank you for joining our newsletter.'
    preference :newsletter_delay, :integer, default: 0
    preference :newsletter_type, :string, default: 'atendpage'
    preference :newsletter_animation, :string, default: 'fade'
    preference :mailchimp_api_key, :string, default: ''
    preference :mailchimp_list_id, :string, default: ''
    preference :mailchimp_enabled, :boolean, default: true
    preference :constant_contact_api_key, :string, default: ''
    preference :constant_contact_api_secret, :string, default: ''
    preference :constant_contact_list_id, :string, default: ''
    preference :constant_contact_access_token, :string, default: ''
    preference :site_address, :string, default: ''
  end
end
