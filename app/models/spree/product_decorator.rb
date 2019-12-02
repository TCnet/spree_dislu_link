Spree::Product.class_eval do



  

  def self.new_arrivals
    config = Spree::DisluConfiguration.new
    num_max_best_sellers = config[:max_best_sellers] || 8
    results = Spree::Product.active.where("").order("created_at desc").limit(num_max_best_sellers.to_i)
  end

  def self.top_rated
    config = Spree::DisluConfiguration.new
    num_max_best_sellers = config[:max_best_sellers] || 8
    results = Spree::Product.active.where("").order("created_at asc").limit(num_max_best_sellers.to_i)
  end


  def self.best_sellers
    config = Spree::DisluConfiguration.new
    num_max_best_sellers = config[:max_best_sellers] || 8


    results = Spree::Product.active.select("spree_products.* , SUM(spree_line_items.quantity) as total_qty , spree_line_items.variant_id").
        joins(:line_items).joins("INNER JOIN spree_orders ON spree_orders.id = spree_line_items.order_id").
        where("spree_orders.state = 'complete'").
        group("spree_line_items.variant_id, spree_products.id")

   

    unless Spree::Config.show_products_without_price
      results = results.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => Spree::Config[:currency])
    end

    results = results.order("total_qty DESC").limit(num_max_best_sellers.to_i)

    return results
  end


end