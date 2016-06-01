module Spree
  Admin::PagesController.class_eval do
    def update_options
      @page.update_attribute(params[:field].to_s, params[:val])
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end
end