class ApplicationController < ActionController::Base
   include Pagy::Backend

 $user_types = ["worker","client"]
 $user_activate = [0,1]
 $order_status = ["nueva","aprobada","rechazada","solicitada","reubicando","preparando","enviada a sucusal","entregada a delivery"]
 $flash_status = ["secondary","important","danger","secondary","information","information","success","success"]



 protected

 def after_sign_in_path_for(resource)
   orders_path
 end

 def after_sign_out_path_for(resource)
  orders_path
 end

 #of class
end
