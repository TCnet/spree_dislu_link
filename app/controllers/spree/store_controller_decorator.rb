module Spree::StoreControllerDecorator
  def self.prepended(base)
   
    base.before_action :get_taxonomies
  end

   def dislu_cart_link
      render partial: 'spree/shared/dislu_link_to_cart'
      fresh_when(simple_current_order)
   end


  protected

    def get_taxonomies
        @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
  
  
  
end

Spree::StoreController.prepend(Spree::StoreControllerDecorator)