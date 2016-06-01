module Spree
  module Core
    module Search
      class Base
        attr_accessor :properties
        attr_accessor :current_user
        attr_accessor :current_currency

        def initialize(params)
          self.current_currency = Spree::Config[:currency]
          @properties = {}
          prepare(params)
        end

        def retrieve_products
          @products = get_base_scope
          curr_page = page || 1

          unless Spree::Config.show_products_without_price
            @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
          end
          @products = @products.page(curr_page).per(per_page)
        end

        def method_missing(name)
          if @properties.has_key? name
            @properties[name]
          else
            super
          end
        end

        protected
          def get_base_scope
            variants_with_options = Spree::Variant.joins(:option_values).where("spree_variants.is_master = false").group("spree_variants.id").collect(&:id)
            matrix_products = Spree::Product.joins(:variants).group("spree_products.id").collect(&:id)

            normal_products = Spree::Product.where("id NOT IN (?)", matrix_products).group("spree_products.id").collect(&:id)
            valid_products = Spree::Product.joins("LEFT JOIN spree_variants ON spree_products.id = spree_variants.product_id AND spree_variants.deleted_at IS NULL").where("spree_variants.out_of_stock = false and (spree_products.id IN (?) or (spree_products.id IN (?) and spree_variants.id IN (?)))", normal_products, matrix_products, variants_with_options).group("spree_products.id").collect(&:id)

            base_scope = Spree::Product.active.enabled.where("spree_products.id IN (?)", valid_products)

            #BEGIN SORT------------------
            sort = @properties[:sort_by]
            if sort.present? && sort != ""
              if sort=='newest'
                base_scope=  base_scope.order('spree_products.created_at desc')
              end
              if sort=='a-z'
                base_scope=  base_scope.order('spree_products.name asc')
              end
              if sort=='z-a'
                base_scope=  base_scope.order('spree_products.name desc')
              end
              if sort=='hight-low'
                base_scope=  base_scope.order('spree_prices.amount desc')
              end
              if sort=='low-hight'
                base_scope=  base_scope.order('spree_prices.amount asc')
              end
            end
            #END SORT---------------------
            #BEGIN FILTER PRICE-----------
            price = @properties[:filter_price]
            if price.present? && price != ""
              base_scope = base_scope.where("spree_prices.amount >= #{price.split('-').first} and spree_prices.amount <= #{price.split('-').last}")
            end
            #END FILTER PRICE-------------
            if @properties[:filter_option_type].present?
              @properties[:filter_option_type].each do |option,val|
                if option!='' && val !=''
                  base_scope = base_scope.with_option_value(option, val)
                end
              end
            end

            if @properties[:wishlist].present?
              base_scope = base_scope.where("spree_products.id IN (?)", @properties[:wishlist])
            end

            base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
            base_scope = get_products_conditions_for(base_scope, keywords)
            base_scope = add_search_scopes(base_scope)
            base_scope = add_eagerload_scopes(base_scope)
            base_scope
          end

          def add_eagerload_scopes scope
            # TL;DR Switch from `preload` to `includes` as soon as Rails starts honoring
            # `order` clauses on `has_many` associations when a `where` constraint
            # affecting a joined table is present (see
            # https://github.com/rails/rails/issues/6769).
            #
            # Ideally this would use `includes` instead of `preload` calls, leaving it
            # up to Rails whether associated objects should be fetched in one big join
            # or multiple independent queries. However as of Rails 4.1.8 any `order`
            # defined on `has_many` associations are ignored when Rails builds a join
            # query.
            #
            # Would we use `includes` in this particular case, Rails would do
            # separate queries most of the time but opt for a join as soon as any
            # `where` constraints affecting joined tables are added to the search;
            # which is the case as soon as a taxon is added to the base scope.
            scope = scope.preload(master: :prices)
            scope = scope.preload(master: :images) if include_images
            scope
          end

          def add_search_scopes(base_scope)
            search.each do |name, scope_attribute|
              scope_name = name.to_sym
              if base_scope.respond_to?(:search_scopes) && base_scope.search_scopes.include?(scope_name.to_sym)
                base_scope = base_scope.send(scope_name, *scope_attribute)
              else
                base_scope = base_scope.merge(Spree::Product.ransack({scope_name => scope_attribute}).result)
              end
            end if search
            base_scope
          end

          # method should return new scope based on base_scope
          def get_products_conditions_for(base_scope, query)
            unless query.blank?
              base_scope = base_scope.like_any([:name, :description], [query])
              #base_scope = base_scope.like_any([:name, :description], query.split)
            end
            base_scope
          end

          def prepare(params)
            @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
            @properties[:keywords] = params[:keywords]
            @properties[:search] = params[:search]
            @properties[:include_images] = params[:include_images]
            @properties[:sort_by] = params[:sort_by]
            @properties[:filter_price] = params[:filter_price]
            @properties[:filter_option_type] = params[:filter_option_type]
            @properties[:wishlist] = params[:wishlist]

            per_page = params[:per_page].to_i
            @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
            if params[:page].respond_to?(:to_i)
              @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
            else
              @properties[:page] = 1
            end
          end
      end
    end
  end
end
