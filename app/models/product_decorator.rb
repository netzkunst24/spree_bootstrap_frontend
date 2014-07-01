Spree::Product.class_eval do
  def content_per_package
    property(Spree::Config.content_per_package_property)
  end

  def is_flooring?
    content_per_package.present?
  end
end
