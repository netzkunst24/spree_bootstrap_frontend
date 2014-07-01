Spree::AppConfiguration.class_eval do
  preference :content_per_package_property, 'Inhalt m² pro Paket'
end

Spree::Config.content_per_package_property = 'Inhalt m² pro Paket'