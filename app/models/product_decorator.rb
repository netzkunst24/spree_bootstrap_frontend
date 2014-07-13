Spree::Product.class_eval do
  def content_per_package
    value = /\d+(,|.)\d*/.match(property(Spree::Config.content_per_package_property))
    return nil if value.nil?
    value[0].gsub(',', '.').to_f
  end

  def is_flooring?
    content_per_package.present?
  end

  #TODO refactor calculate ONCE on import!?
  def price_per_package(currency)
    return price_in(currency).price unless is_flooring?
    Spree::Money.new(price_in(currency).price * content_per_package)
  end
end
