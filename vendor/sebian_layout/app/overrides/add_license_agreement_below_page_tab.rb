Deface::Override.new(
    virtual_path: 'spree/layouts/admin',
    name: 'license_agreement_admin_sidebar_menu',
    insert_bottom: '#page_admin_menu',
    partial: 'spree/admin/shared/license_agreement_sidebar_menu'
)
