Spree::HomeController.class_eval do
  def index
    @searcher = build_searcher(params)
    @products = @searcher.retrieve_products
    render layout: 'home_rowsets'
  end
end