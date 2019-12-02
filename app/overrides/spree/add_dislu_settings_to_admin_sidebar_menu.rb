Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'dislu_settings_admin_sidebar_menu',
  insert_bottom: 'nav',
  partial: 'spree/admin/shared/dislu_sidebar_menu'
)