module Spree
  module Admin
    TaxonomiesController.class_eval do
      def toggle_featured
        @taxonomy.featured ? @taxonomy.unfeatured! : @taxonomy.featured! if @taxonomy.present?
        render :nothing => true, :status => 200, :content_type => 'text/html'
      end
    end
  end
end