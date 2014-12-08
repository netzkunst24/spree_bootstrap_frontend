Spree::Shipment.class_eval do
  #TODO needed for hacky delivery step removal. taken from from spree 2.4 (http://stackoverflow.com/questions/22461979/skip-checkout-step-but-make-associations)
  def update_amounts
    if selected_shipping_rate
      self.update_columns(
          cost: selected_shipping_rate.cost,
          updated_at: Time.now,
      )
    end
  end
end