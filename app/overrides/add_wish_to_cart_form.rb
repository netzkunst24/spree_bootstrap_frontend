Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_wish_to_cart_form",
                     :insert_bottom => "#additionals",
                     :partial => "spree/products/wishlist_form",
                     :disabled => true)
