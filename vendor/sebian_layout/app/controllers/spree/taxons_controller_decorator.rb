module Spree
  TaxonsController.class_eval do
    def show
      @taxon = Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true, sort_by: params[:sort_by], filter_price: params[:filter_price], filter_option_type: params[:filter_option_type]))
      @products = @searcher.retrieve_products
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      sub_query = Classification::where(:taxon_id => @taxon.id).select("product_id").to_sql
      @variant_ids = Variant.where(:is_master=>1).where("deleted_at IS NULL").where("product_id IN (#{sub_query})").collect(&:id)
    end
  end
end
