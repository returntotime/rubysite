Deface::Override.new(:virtual_path => "spree/admin/shared/_menu",
                     :name => "import_products_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:product_imports) %>",
                     :disabled => false)
