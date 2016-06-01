Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "blog_admin_tabs",
                     :insert_bottom => "#main-sidebar-removed, [data-hook='admin_tabs_removed'], #admin_tabs[data-hook-removed]",
                     :text => "<%= tab(:blog_entries, :label => 'Blog', :url => spree.admin_blog_entries_path, :icon => 'file') if can? :manage, Spree::BlogEntry %>",
                     :disabled => false)
