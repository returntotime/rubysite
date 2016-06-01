module Spree
  module FrontendHelper
    def body_class
      @body_class ||= content_for?(:sidebar) ? 'two-col' : 'one-col'
      @body_class
    end

    # def breadcrumbs(taxon, separator="&nbsp;")
    #   return "" if current_page?("/") || taxon.nil?
    #   separator = raw(separator)
    #   crumbs = [content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:home), itemprop: "name"), spree.root_path, itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")]
    #   if taxon
    #     crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:products), itemprop: "name"), spree.products_path, itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    #     crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, content_tag(:span, link_to(content_tag(:span, ancestor.name, itemprop: "name"), seo_url(ancestor), itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement") } unless taxon.ancestors.empty?
    #     crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, taxon.name, itemprop: "name") , seo_url(taxon), itemprop: "url"), itemprop: "item"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    #   else
    #     crumbs << content_tag(:li, content_tag(:span, Spree.t(:products), itemprop: "item"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    #   end
    #   crumb_list = content_tag(:ol, raw(crumbs.flatten.map{|li| li.mb_chars}.join), class: 'breadcrumb', itemscope: "itemscope", itemtype: "https://schema.org/BreadcrumbList")
    #   content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'col-md-12')
    # end

    def display_menu(menu, level = 0)
      child_menus = menu.children.visible.includes(:children).order(:position)
      html = "<li class='#{menu.children.present? ? 'menu-position' : ''}'>"
      html += "<a href='#{menu.url}'>#{menu.link_text}#{(child_menus.present? && level > 0) ? '<i class="fa fa-angle-right pull-right"></i>' : ''}</a>"
      html += "<span class='parent-nav'></span>" if child_menus.present?
      if child_menus.count > 0
        sub_menu_kclass = "sub-" * level + "sub-menu"
        html += "<div class='#{sub_menu_kclass}'>"
        html += "<div class='hidden visible-xs sub-menu-back'>back</div>"
        html += "<ul><li>"
        child_menus.each do |sub_menu|
          html += display_menu(sub_menu, level + 1)
        end
        html += "</li></ul>"
        html += "</div>"
      end
      html += '</li>'
      html
    end

    def format_price(price_or_product, currency = "usd")
      if price_or_product.class.name == "Spree::Product" || price_or_product.class.name == "Spree::Variant"
        price = display_price(price_or_product)
      else
        price = number_to_currency(price_or_product.to_s)
      end
      #price = price.gsub("$", "") + " USD" if currency.downcase == "usd"
      price = price.gsub("$$", "$") if currency.downcase == "usd"
      price
    end

    def breadcrumbs(taxon, product = nil, text = nil, collection = nil)
      return "" if current_page?("/")
      crumbs = [content_tag(:li, link_to(Spree.t(:home), spree.root_path, itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")]
      unless collection.nil?
        collection.each do |alink, atext|
          crumbs << content_tag(:li, link_to( atext, alink, itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
        end
      else
        unless text.nil?
          crumbs << [content_tag(:li, content_tag(:span, text, itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")]
        else
          if taxon
            crumbs << content_tag(:li, link_to(Spree.t(:shop), spree.products_path, itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
            crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, link_to(ancestor.name, seo_url(ancestor), itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement") } unless taxon.ancestors.empty?
            crumbs << content_tag(:li,link_to(taxon.name, seo_url(taxon), itemprop: "url"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
          else
            crumbs << content_tag(:li, link_to( Spree.t(:shop), spree.products_path, itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
          end

          unless product.nil?
            crumbs << content_tag(:li, link_to( product.name, spree.products_path, itemprop: "url"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
          end
        end
      end
      content_tag(:ol, raw(crumbs.flatten.map{|li| li.mb_chars}.join), class: 'breadcrumb', itemscope: "itemscope", itemtype: "https://schema.org/BreadcrumbList")
    end

    def checkout_progress
      states = @order.checkout_steps
      items = states.map do |state|
        text = Spree.t("order_state.#{state}").titleize

        css_classes = []
        current_index = states.index(@order.state)
        state_index = states.index(state)

        if state_index < current_index
          css_classes << 'completed'
          text = link_to text, checkout_state_path(state)
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
          content_tag('li', content_tag('a', text), class: css_classes.join(' '))
        end
      end
      content_tag('ul', raw(items.join("\n")), class: 'progress-steps nav nav-pills nav-justified', id: "checkout-step-#{@order.state}")
    end

    def flash_messages(opts = {})
      ignore_types = ["order_completed"].concat(Array(opts[:ignore_types]).map(&:to_s) || [])

      flash.each do |msg_type, text|
        unless ignore_types.include?(msg_type)
          concat(content_tag :div, text, class: "text-center alert alert-#{msg_type}")
        end
      end
      nil
    end

    def link_to_cart(text = nil)
      text = text ? h(text) : Spree.t('cart')
      css_class = nil

      if simple_current_order.nil? or simple_current_order.item_count.zero?
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{text}: (#{Spree.t('empty')})"
        css_class = 'empty'
      else
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{text}: (#{simple_current_order.item_count})  <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
        css_class = 'full'
      end

      link_to text.html_safe, spree.cart_path, :class => "cart-info #{css_class}"
    end

    # helper to determine if its appropriate to show the store menu
    def store_menu?
      %w{thank_you}.exclude? params[:action]
    end

    def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.leaf?
      content_tag :div, class: 'list-group' do
        root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item active' : 'list-group-item'
          link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
        end.join("\n").html_safe
      end
    end

    def review_avg(product)
      sum_val = product.reviews.approved.sum('rating').to_f
      count_val = product.reviews.approved.count
      avg = sum_val / count_val
      stars = ''
      for i in 1..Spree::Reviews::Config.stars do
        if i <= avg
          stars << content_tag(:i,nil,:class => "fa fa-star")
        else
          if (i - avg) > 0 && (i - avg) < 1
            stars << content_tag(:i,nil,:class => "fa fa-star-half-o")
          else
            stars << content_tag(:i,nil,:class => "fa fa-star-o")
          end
        end
      end
      content_tag(:div, stars.html_safe, :class => "stars").html_safe
    end
  end
end
