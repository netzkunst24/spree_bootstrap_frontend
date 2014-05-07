Spree::BaseHelper.module_eval do
 def vat_and_shipping(product)
   #TODO first is not neccessary the right
   amount = (product.tax_category.tax_rates.first.amount * 100).to_s.gsub '.0', ''
   "inkl. #{amount}% MwSt., zzgl. Versand"
 end

  def estimated_delivery(product)
    quantifier = Spree::Stock::Quantifier.new(product)
    "<span class='#{'available' if quantifier.can_supply?(1)}'>Lieferbar</span> in 3-5 Werktagen <!--(#{quantifier.total_on_hand})-->".html_safe
  end
end