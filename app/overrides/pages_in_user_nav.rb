Deface::Override.new(:virtual_path => "spree/shared/_user_nav",
                     :name => "pages_in_user_nav",
                     :insert_bottom => "#ws-user-nav > ul",
                     :partial => "spree/static_content/static_content_user_nav",
                     :disabled => false)