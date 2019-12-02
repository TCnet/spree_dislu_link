module Spree::CheckoutControllerDecorator
  def self.prepended(base)
    base.layout 'spree/layouts/one_page'
  end
  
  
  
end

Spree::CheckoutController.prepend(Spree::CheckoutControllerDecorator)