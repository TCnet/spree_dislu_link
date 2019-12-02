module Spree::OrdersControllerDecorator
  def self.prepended(base)
    base.layout 'spree/layouts/one_page'
    #base.respond_to :js, :only => [:populate, :update]
  end


  
  
end

Spree::OrdersController.prepend(Spree::OrdersControllerDecorator)