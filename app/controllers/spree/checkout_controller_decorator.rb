Spree::CheckoutController.class_eval do
  layout 'checkout'

  def before_delivery
    if @order.needs_delivery?
      #user needs to select shipping, default behaviour
      @order.create_proposed_shipments
    else
      #we select the shipping for the user
      @order.select_default_shipping
      @order.next #go to next step
      #default logic for finalizing unless he can't select payment_method
      if @order.completed?
        session[:order_id] = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = 'nothing special'
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end
    end
  end
end