Spree::Order.class_eval do
  #remove_checkout_step :delivery
  def needs_delivery?
    #your logic goes here
    return false
  end

  def select_default_shipping
    #clone_billing_address #uncomment if user just types in one address
    create_proposed_shipments #creates the shippings
    shipments.first.update_amounts #uses the first shippings
    update_totals #updates the order
  end
end