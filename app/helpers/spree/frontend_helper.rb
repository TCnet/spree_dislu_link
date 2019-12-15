module Spree
  module FrontendHelper
    def body_class
      @body_class ||= content_for?(:sidebar) ? 'two-col' : 'one-col'
      @body_class
    end
    
    def is_new_product(product)
      config = Spree::DisluConfiguration.new
      days_is_new = config[:days_is_new] || 20
      product.created_at > Time.now - days_is_new.to_i.days
      
    end

    def get_local_url
       default_url = root_path
       if SpreeI18n::Config.available_locales.many? 
        default_url = root_path(locale: I18n.locale)
       end
       default_url+"#"
    end

    def tag_position(num=1)
      #html('<meta itemprop="position" content="1">')
      content_tag(:meta ,'',itemprop: 'position', content: num.to_s)
    end

    def get_url(url='')
      if request.standard_port?
        request.protocol+request.host+url
      else
        request.protocol+request.host_with_port+url
      end

      #request.protocol+request.host+url
      
    end

    def dislu_breadcrumbs(taxon, separator = '')
      return '' if current_page?('/') || taxon.nil?
      num=1

      separator = raw(separator)
      firts = content_tag :li , itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'trail-item' do
        concat content_tag(:span, link_to(content_tag(:span, Spree.t(:home), itemprop: 'name'), get_url(spree.root_path), itemprop: 'url') + separator, itemprop: 'item')
        concat (tag_position num)
      end
      crumbs= []
      crumbs << firts


     
      if taxon
        num +=1
        t1 = content_tag :li, itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'trail-item begin' do
          concat content_tag(:span, link_to(content_tag(:span, Spree.t(:products), itemprop: 'name'),get_url(spree.products_path), itemprop: 'url') + separator, itemprop: 'item')
          concat (tag_position num)
        end
        crumbs << t1

        unless taxon.ancestors.empty?
          ss=''
          taxon.ancestors.each do |ancestor|
            num +=1
            ob = content_tag :li, itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'trail-item' do
              concat content_tag(:span, link_to(content_tag(:span, ancestor.name, itemprop: 'name'), get_url(seo_url(ancestor)), itemprop: 'url') + separator, itemprop: 'item')
              concat (tag_position num)
            end
            ss+=ob
          end
          crumbs << ss
        end
        num +=1
        last = content_tag :li, class: 'trail-item trail-end active', itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement' do
          concat content_tag(:span, link_to(content_tag(:span, taxon.name, itemprop: 'name'), get_url(seo_url(taxon)), itemprop: 'url'), itemprop: 'item')
          concat (tag_position num)
        end

        crumbs << last
      else
        rs= content_tag :li,class: 'trail-item trail-end active', itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement' do
          concat content_tag(:span, Spree.t(:products), itemprop: 'item')
          concat (tag_position num)
        end

        crumbs << rs
      end
      crumb_list = content_tag(:ul, raw(crumbs.flatten.map(&:mb_chars).join), class: 'trail-items breadcrumb', itemscope: 'itemscope', itemtype: 'https://schema.org/BreadcrumbList')
      content_tag(:div, crumb_list, id: 'breadcrumbs', class: 'breadcrumb-trail breadcrumbs', aria: { label: 'breadcrumb' })
    end

    def spree_breadcrumbs(taxon, separator = '')
      return '' if current_page?('/') || taxon.nil?

      separator = raw(separator)
      crumbs = [content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:home), itemprop: 'name'), spree.root_path, itemprop: 'url') + separator, itemprop: 'item'), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')]
      if taxon
        crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:products), itemprop: 'name'), spree.products_path, itemprop: 'url') + separator, itemprop: 'item'), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')
        crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, content_tag(:span, link_to(content_tag(:span, ancestor.name, itemprop: 'name'), seo_url(ancestor), itemprop: 'url') + separator, itemprop: 'item'), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item') } unless taxon.ancestors.empty?
        crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, taxon.name, itemprop: 'name'), seo_url(taxon), itemprop: 'url'), itemprop: 'item'), class: 'active breadcrumb-item', itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement')
      else
        crumbs << content_tag(:li, content_tag(:span, Spree.t(:products), itemprop: 'item'), class: 'active', itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement')
      end
      crumb_list = content_tag(:ol, raw(crumbs.flatten.map(&:mb_chars).join), class: 'breadcrumb', itemscope: 'itemscope', itemtype: 'https://schema.org/BreadcrumbList')
      content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'col-12 mt-4', aria: { label: 'breadcrumb' })
    end

    def checkout_progress(numbers: false)
      states = @order.checkout_steps
      items = states.each_with_index.map do |state, i|
        text = Spree.t("order_state.#{state}").titleize
        text.prepend("#{i.succ}. ") if numbers

        css_classes = ['nav-item']
        current_index = states.index(@order.state)
        state_index = states.index(state)

        if state_index < current_index
          css_classes << 'completed'
          text = link_to text, checkout_state_path(state), class: 'nav-link'
        end

        css_classes << 'next' if state_index == current_index + 1
        css_classes << 'active' if state == @order.state
        css_classes << 'first' if state_index == 0
        css_classes << 'last' if state_index == states.length - 1
        # No more joined classes. IE6 is not a target browser.
        # Hack: Stops <a> being wrapped round previous items twice.
        if state_index < current_index
          content_tag('li', text, class: css_classes.join(' '))
        else
          content_tag('li', content_tag('a', text, class: "nav-link #{'active text-white' if state == @order.state}"), class: css_classes.join(' '))
        end
      end
      content_tag('ul', raw(items.join("\n")), class: 'progress-steps nav  nav-justified flex-column flex-md-row', id: "checkout-step-#{@order.state}")
    end

    def flash_messages(opts = {})
      ignore_types = ['order_completed'].concat(Array(opts[:ignore_types]).map(&:to_s) || [])

      flash.each do |msg_type, text|
        # concat(content_tag(:div, text, class: "alert alert-#{msg_type} alert-dismissable") 
        # ) unless ignore_types.include?(msg_type)
        unless ignore_types.include?(msg_type)
           
           button =content_tag :a ,class: 'close', :"data-dismiss" => "alert", :"aria-hidden" =>'true' do
              concat content_tag(:i, nil, :class => 'fa fa-times')
              ''
           end
            tags = content_tag(:div, class: "alert alert-#{msg_type} alert-dismissable fade show") do
               concat text
               concat button
              end
           

           concat(tags)
        end 
      end
      nil
    end

    def get_simple_current_order
      return simple_current_order
    end

    def dislu_link_cart_num
      if simple_current_order.nil? || simple_current_order.item_count.zero?
        return 0
      else
        return simple_current_order.item_count
      end
    end

    def mobil_link_cart(text=nil,css_class=nil)
      text = text ? h(text) : Spree.t('cart')
      css_class = nil

      if simple_current_order.nil? || simple_current_order.item_count.zero?
        text = "<span class='icon'><i class='fa fa-shopping-basket' aria-hidden='true'></i><span class='count-icon'>0</span></span><span class='text'>#{text}</span>"
        css_class = 'empty'
      else
        text = "<span class='icon'><i class='fa fa-shopping-basket' aria-hidden='true'></i><span class='count-icon'>#{simple_current_order.item_count}</span></span><span class='text'>#{text}</span>"
        css_class = ''
      end
      link_to text.html_safe, spree.cart_path, class: "#{css_class}"
    end

    def link_to_cart(text = nil)
      text = text ? h(text) : Spree.t('cart')
      css_class = nil

      if simple_current_order.nil? || simple_current_order.item_count.zero?
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{text}: (#{Spree.t('empty')})"
        css_class = 'empty'
      else
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{text}: (#{simple_current_order.item_count})
                <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
        css_class = 'full'
      end

      link_to text.html_safe, spree.cart_path, class: "cart-info nav-link #{css_class}"
    end

    def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.leaf?

      content_tag :div, class: 'list-group' do
        taxons = root_taxon.children.map do |taxon|
          css_class = current_taxon&.self_and_ancestors&.include?(taxon) ? 'list-group-item list-group-item-action active' : 'list-group-item list-group-item-action'
          link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
        end
        safe_join(taxons, "\n")
      end
    end

    def dislu_taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.leaf?

      content_tag :ul, class: 'list-categories' do
        taxons = root_taxon.children.map do |taxon|
          css_class = current_taxon&.self_and_ancestors&.include?(taxon) ? 'list-item active' : 'list-item'
          content_tag :li, class: css_class do
            link_to(taxon.name, seo_url(taxon)) + taxons_tree(taxon, current_taxon, max_level - 1)
          end
          
        end
        safe_join(taxons, "\n")
      end
    end

    def set_image_alt(image)
      return image.alt if image.alt.present?
    end
  end
end
