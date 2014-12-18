Spree::ProductsHelper.module_eval do
  # returns the formatted price for the specified variant as a difference from product price
  def variant_price_diff(variant)
    variant_amount = variant.amount_in(current_currency)
    product_amount = variant.product.amount_in(current_currency)
    return if variant_amount == product_amount || product_amount.nil?
    diff   = variant.amount_in(current_currency) - product_amount
    amount = Spree::Money.new(diff.abs, currency: current_currency).to_html
    label  = diff > 0 ? '+' : '-'
    "(#{label}#{amount})".html_safe
  end

  def vat_and_shipping(product)
    #TODO first is not neccessary the right
    amount = (product.tax_category.tax_rates.first.amount * 100).to_s.gsub '.0', ''
    "inkl. #{amount}% MwSt., zzgl. Versand"
  end

  def estimated_delivery(product)
    #TODO check for selected Variant here not for first !!!
    #quantifier = Spree::Stock::Quantifier.new(product.variants.first)
    #"<span class='#{'available' if quantifier.can_supply?(1)}'>Lieferbar</span> in 3-5 Werktagen".html_safe
    "<span class='available'>Lieferbar</span> in 3-5 Werktagen".html_safe
  end

  def sample_variant(product)
    sample_option_type = product.option_types.find_by(name: Spree::Config.sample_option)
    sample_option = product.options.find_by(option_type_id: sample_option_type.id) if sample_option_type.present?
    product.variants.find_by(product_id: sample_option.product_id) if sample_option.present?
  end
end