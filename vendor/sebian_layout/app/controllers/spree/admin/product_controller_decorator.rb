module Spree
  Admin::ProductsController.class_eval do
    def update_options
      @product.update_attribute(params[:field].to_s, params[:val])
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end
end