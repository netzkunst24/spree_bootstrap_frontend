Spree::BaseHelper.module_eval do
  def link_to_cart(text = nil)
    #return "" if current_spree_page?(spree.cart_path) #minicart needs the cart link on all pages

    text = text ? h(text) : Spree.t('cart')
    css_class = nil

    #<span class='amount'>#{current_order.display_total.to_html}</span>
    if current_order.nil? or current_order.item_count.zero?
      text = "<span class='icon-basket'>0</span> <span class='basket-title'>#{text}</span>".html_safe
      css_class = 'empty'
    else
      text = "<span class='icon-basket'>#{current_order.item_count}</span> <span class='basket-title'>#{text}</span>".html_safe
      css_class = 'full'
    end

    link_to text, spree.cart_path, :class => "cart-info #{css_class}"#, :data => {:toggle => 'dropdown'}
  end

  def flash_messages(opts = {})
    opts[:ignore_types] = [:commerce_tracking].concat(Array(opts[:ignore_types]) || [])

    flash.each do |msg_type, text|
      unless opts[:ignore_types].include?(msg_type)
        concat(content_tag :div, text, class: "alert alert-#{msg_type}")
      end
    end
    nil
  end

  def display_price_per(product_or_variant, property_name = 'Paket qm', unit = 'm²')
    value = product_or_variant.property(property_name)
    return display_price(product_or_variant) if value.nil?

    divisor = /\d+,\d*/.match(value)[0].gsub(',', '.').to_f
    price = product_or_variant.price_in(current_currency).price
    Spree::Money.new(price/divisor).to_html + "&nbsp;<span class='per-unit'>/#{unit}</span>".html_safe
  end


  def taxons_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, class: 'list-group' do
      root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item current' : 'list-group-item'
        content_tag :li, class: css_class do
         link_to(taxon.name, seo_url(taxon)) +
         taxons_tree(taxon, current_taxon, max_level - 1)
        end
      end.join("\n").html_safe
    end
  end

  def breadcrumbs(taxon, separator='&nbsp;', product=nil)
    return "" if current_page?('/') || taxon.nil?
    separator = raw(separator)
    crumbs = [content_tag(:li, link_to(Spree.t(:home), spree.root_path) + separator)]
    if taxon
      crumbs << content_tag(:li, link_to(Spree.t(:products), products_path) + separator)
      crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, link_to(ancestor.name , seo_url(ancestor)) + separator) } unless taxon.ancestors.empty?
      crumbs << content_tag(:li, content_tag(:span, link_to(taxon.name , seo_url(taxon))))
    else
      crumbs << content_tag(:li, content_tag(:span, Spree.t(:products)))
    end

    crumbs << content_tag(:li, product.name, class: 'active') if product

    crumb_list = content_tag(:ol, raw(crumbs.flatten.map{|li| li.mb_chars}.join), class: 'breadcrumb')
    content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'col-md-12')
  end

  def get_categories(opts = {})
    exclude = Array(opts[:not])
    Spree::Taxonomy.find_by(name: 'Kategorien').root.children.order(:position).reject { |taxon| exclude.include? taxon.name }
  end

  def link_to_wishlist
    if spree_current_user
      #TODO Wishlist Size Bdge is onlly form first/default list either allow only one list or count all or remove badge!
      wishlist_length = spree_current_user.wishlist.wished_products.length
      text = "Merkliste <span class='badge'>#{wishlist_length}</span>".html_safe
      link_to text, spree.wishlists_path
    end
  end

  def category_and_manufacturer(product)
    category = product.cached_category
    brand = product.cached_manufacturer
    category_tag = category.nil? ? '' : content_tag(:span, category.name, class: 'category')
    brand_tag = brand.nil? ? '' : content_tag(:span, brand.name, class: 'manufacturer', itemprop: 'brand')
    brand_tag + ' ' + category_tag
  end

end