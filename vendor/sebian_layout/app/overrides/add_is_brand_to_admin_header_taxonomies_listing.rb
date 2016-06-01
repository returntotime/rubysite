Deface::Override.new(:virtual_path => 'spree/admin/taxonomies/_list',
                     :name => 'add_is_brand_to_admin_header_taxonomies_listing',
                     :insert_before => "th.actions",
                     :text => "<th>Featured</th><th>Is Brand</th><th>Brand Image</th>")