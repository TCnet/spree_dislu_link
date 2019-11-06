Deface::Override.new(
    virtual_path: 'spree/products/show',
    name: 'add_dislu_link_to_products_show',
    insert_after: 'div[data-hook="description"]',
    partial: 'spree/shared/add_dislu_link_to_products_show'
)