module Spree
  ProductsController.class_eval do
    def index
      @searcher = build_searcher(params.merge(include_images: true, sort_by: params[:sort_by], filter_price: params[:filter_price], filter_option_type: params[:filter_option_type]))
      @products = @searcher.retrieve_products
      @variant_ids = Spree::Variant.where(:is_master=>1).where("deleted_at IS NULL").collect(&:id)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

    def check_view_product
      if !@product.enabled || (@product.out_of_stock? && !@product.can_supply?)
        flash[:error] = "Product '#{@product.name}' is no longer exists"
        redirect_to root_path and return
      end
    end

    def get_options
        option_values = []
        params.each do |key, val|
          if key.include?("option_value")
            option_values.push val
          end
        end
        variants = Spree::Variant.joins("INNER JOIN spree_option_values_variants ON spree_option_values_variants.variant_id = spree_variants.id")
                                  .where("spree_variants.id IN (?) AND spree_option_values_variants.option_value_id IN (?)", params[:variants], option_values)
                                  .in_stock.select(["spree_variants.id AS id"]).collect(&:id)

        current_option_values = Spree::OptionType.find(params[:current_option_type]).option_values.collect(&:id)

        expected_values = Spree::OptionValue.joins("INNER JOIN spree_option_values_variants ON spree_option_values_variants.option_value_id = spree_option_values.id")
                                            .where("variant_id IN (?) AND option_value_id IN (?)", variants, current_option_values)
        render :json => {:values => expected_values} and return
    end

  end
end