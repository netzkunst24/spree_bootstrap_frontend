Deface::Override.new(:virtual_path => "spree/shared/_user_nav",
                     :name => "auth_shared_login_bar_mws",
                     :insert_before => "li#watchlist",
                     :partial => "spree/shared/login_bar",
                     :disabled => false)

