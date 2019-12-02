module Spree
  class HomeController < Spree::StoreController
    
    before_action :load_products_data , only: [:index, :show]
    helper 'spree/products'
    
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @home_sliders = Spree::DisluSlider.home_sliders

    end

    private 

     def load_products_data
      config = Spree::DisluConfiguration.new
       if (config.has_preference?(:show_best_sellers) && config[:show_best_sellers])
          @best_sellers = (Spree::Product.best_sellers rescue nil)
       end
       @new_arrivals = (Spree::Product.new_arrivals rescue nil)
       @top_rated = (Spree::Product.top_rated rescue nil)
      end
  end
end
