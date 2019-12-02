module Spree::ProductsControllerDecorator
  
  def related
    load_resource
    @relation_types = Spree::Product.relation_types
  end
end

Spree::ProductsController.prepend(Spree::ProductsControllerDecorator)