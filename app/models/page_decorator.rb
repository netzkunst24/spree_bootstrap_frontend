Spree::Page.class_eval do
  scope :footer_first, -> { where(:show_in => 'footer_first').visible }
  scope :footer_second, -> { where(:show_in => 'footer_second').visible }
  scope :footer_third, -> { where(:show_in => 'footer_third').visible }
  scope :footer_fourth, -> { where(:show_in => 'footer_fourth').visible }
end



