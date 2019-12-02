module Spree
 module ProductsHelper
    def is_new_product(product)
      #config = Spree::DisluConfiguration.new
      days_is_new =SpreeDisluLink::Config[:days_is_new] || 20
      product.created_at > Time.now - days_is_new.to_i.days
      
    end
  end
end