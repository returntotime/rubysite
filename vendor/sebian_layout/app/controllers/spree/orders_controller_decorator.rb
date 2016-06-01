Spree::OrdersController.class_eval do
  before_filter :apply_coupon_code, :only=>[:update]
  before_filter :estimate_shipping_tax, :only=>[:update]

  def update
    current_state = @order.state
    # Keep address for shipping estimation & current state of order is payment
    if params[:estimate_shipping].blank? && current_state != "payment"
      params[:order].delete :ship_address_attributes
      params[:order].delete :bill_address_attributes
    end


    if @order.contents.update_cart(order_params)
      @order.update_from_params(params[:order], permitted_checkout_attributes, request.headers.env)
      respond_with(@order) do |format|
        format.html do
          if params.has_key?(:checkout)
            @order.next if @order.cart?

            # Go to delivery if the user estimated shipping & tax
            if current_state == "payment"
              while @order.state != "payment"
                @order.next
              end
            end
            redirect_to checkout_state_path(@order.state)
          else
            if params[:estimate_shipping].present?
              while @order.state != "payment"
                @order.next
              end
            end
            redirect_to cart_path
          end
        end
      end
    else
      respond_with(@order)
    end
  end

  private
  def apply_coupon_code
    if params[:order] && params[:order][:coupon_code]
      @order ||= current_order
      @order.coupon_code = params[:order][:coupon_code]
      handler = Spree::PromotionHandler::Coupon.new(@order).apply
      if handler.error.present?
        flash[:error] = handler.error
      elsif handler.success
        flash[:success] = handler.success
      end
    end
  end

  def estimate_shipping_tax
    if params[:order] && params[:order][:ship_address_attributes]
      @order ||= current_order
      shipping_address = @order.ship_address
      billing_address = @order.bill_address
      ship_address = {
          "firstname"=> shipping_address.present? ? shipping_address.firstname : 'First name',
          "lastname"=> shipping_address.present? ? shipping_address.lastname : 'Last name',
          "address1"=> shipping_address.present? ? shipping_address.address1 : 'Address 1',
          "address2"=> shipping_address.present? ? shipping_address.address2 : 'Address 2',
          "city"=> shipping_address.present? ? shipping_address.city : 'City',
          "phone"=> shipping_address.present? ? shipping_address.phone : 'Phone'
      }

      if params[:order] && params[:order][:ship_address_attributes] && params[:order][:ship_address_attributes][:zipcode].blank?
        params[:order][:ship_address_attributes][:zipcode] = shipping_address.present? ? shipping_address.zipcode : 'Zip code'
      end

      if billing_address.blank?
        params[:order][:bill_address_attributes] = params[:order][:ship_address_attributes].merge(ship_address)
      else
        params[:order][:bill_address_attributes] = {
            "firstname"=> billing_address.firstname,
            "lastname"=> billing_address.lastname,
            "address1"=> billing_address.address1,
            "address2"=> billing_address.address2,
            "city"=> billing_address.city,
            "country_id"=> billing_address.country_id,
            "state_id"=> billing_address.state_id,
            "zipcode"=> billing_address.zipcode ,
            "phone"=> billing_address.phone
        }
      end

      if shipping_address.present?
        ship_address.merge!("id" => shipping_address.id)
      end
      params[:order][:ship_address_attributes].merge!(ship_address)
      if billing_address.present?
        params[:order][:bill_address_attributes].merge!("id" => billing_address.id)
      end
      @order.reload
      # params[:estimate_shipping_tax] = true
    end
  end
end