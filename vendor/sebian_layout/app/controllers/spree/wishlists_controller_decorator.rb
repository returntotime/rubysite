module Spree
  WishlistsController.class_eval do

    before_action :check_login, :except => [:find_wishlists, :wishlist_options, :show]

    def show
      @user_wishlists_count = @wishlist.present? ? @wishlist.wished_products.count : 0
      if @user_wishlists_count > 0
        @searcher = build_searcher(params.merge(wishlist: @wishlist.wished_products.map { |x| x.variant.product.id }, include_images: true, sort_by: params[:sort_by], filter_price: params[:filter_price], filter_option_type: params[:filter_option_type]))
        @products = @searcher.retrieve_products
      else
        @products = nil
      end
    end

    def destroy
      @wishlist.destroy
      respond_with(@wishlist) do |format|
        format.html { redirect_to wishlists_path }
      end
    end

    def find_wishlists
      @wishlists = Spree::Wishlist.publish

      # Check for searching
      if params[:firstname].present? || params[:lastname].present?
        user = Spree::User
        if params[:firstname].present?
          user = user.where("firstname like ?", "%#{params[:firstname]}%")
        end
        if params[:lastname].present?
          user = user.where("lastname like ?", "%#{params[:lastname]}%")
        end
        @wishlists = @wishlists.where('user_id IN (?)', (user.present? && user.count > 0) ? user.collect(&:id) : '')
      end

      @wishlists = @wishlists.page(params[:page] || 1).per(10)
    end

    def check_login
      unless spree_current_user.present?
        flash[:warning] = "You must create an account and login to create/manage a wish list"
        redirect_to wishlist_options_wishlists_path and return
      end
    end
  end
end
