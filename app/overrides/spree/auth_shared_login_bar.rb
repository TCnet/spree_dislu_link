Deface::Override.new(:virtual_path => "spree/shared/_dislu_top_bar",
                     :name => "auth_shared_login_bar",
                     :insert_bottom => "ul#user_links",
                     :partial => "spree/shared/login_bar",
                     :disabled => false, 
                     #:sequence => {:after => "auth_shared_login_bar"}
                     )