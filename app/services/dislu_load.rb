module DisluLoad
  def self.load_best_sellers
      config = Spree::DisluConfiguration.new
      if ((config.has_preference?(:show_best_sellers) && config[:show_best_sellers]))
        @best_sellers = (Spree::Product.best_sellers rescue nil)
      end
    end

end
