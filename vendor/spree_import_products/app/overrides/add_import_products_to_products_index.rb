#Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
     #                :name         => "import_products",
     #               :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
     #                :text         => "<%= tab(:product_imports) %>")

#Deface::Override.new(:virtual_path => 'spree/admin/taxonomies/_list',
#                     :name => 'add_import_products_to_admin_body_taxonomies_listing',
#                     :insert_before => "td.actions",
#                     :partial => "spree/admin/taxonomies/is_brand_body_listing",
#                     :text         => "<%= tab(:product_imports) %>")

#Deface::Override.new(:virtual_path => 'spree/admin/shared/_main_menu',
#                     :name => 'add_import_products_to_admin_body_products_listing',
#                     #:insert_bottom => "[data-hook='toolbar'], #toolbar[data-hook]",
#                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
#                     :partial => "spree/admin/shared/main_menu",
#                     :text         => "<%= tab(:product_imports) %>")

