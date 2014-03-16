['first', 'second', 'third', 'fourth'].each do |position|
  Deface::Override.new(:virtual_path => "spree/shared/_footer",
                       :name => "pages_in_footer_#{position}",
                       :insert_bottom => "#footer-#{position}",
                       :partial => "spree/static_content/static_content_footer_#{position}",
                       :disabled => false)
end