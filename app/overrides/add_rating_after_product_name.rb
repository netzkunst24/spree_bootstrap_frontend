Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_ration_after_product_name",
                     :insert_after => ".product-title",
                     :partial => "spree/shared/rating_frontend",
                     :disabled => false)