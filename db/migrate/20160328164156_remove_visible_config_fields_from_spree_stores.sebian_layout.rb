# This migration comes from sebian_layout (originally 20160328164043)
class RemoveVisibleConfigFieldsFromSpreeStores < ActiveRecord::Migration
  def change
    remove_column :spree_stores, :show_slider,         :boolean, default: true
    remove_column :spree_stores, :show_new_arrival,    :boolean, default: true
    remove_column :spree_stores, :show_popular_weekly, :boolean, default: true
    remove_column :spree_stores, :show_in_this_look,   :boolean, default: true
    remove_column :spree_stores, :show_the_blog,       :boolean, default: true
    remove_column :spree_stores, :show_our_story,      :boolean, default: true
    remove_column :spree_stores, :show_our_service,    :boolean, default: true
    remove_column :spree_stores, :show_what_client_say,:boolean, default: true
    remove_column :spree_stores, :show_contact_us,     :boolean, default: true
    remove_column :spree_stores, :show_subcribe,       :boolean, default: true
    remove_column :spree_stores, :show_our_client,     :boolean, default: true
  end
end
