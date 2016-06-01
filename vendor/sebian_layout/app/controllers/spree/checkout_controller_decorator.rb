module Spree
  CheckoutController.class_eval do
    before_filter :check_registration, :except => [:update, :edit, :registration, :update_registration]

    # def update
    #   if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
    #     @order.temporary_address = !params[:save_user_address]
    #     if @order.state == 'payment'
    #       unless request.xhr?
    #         unless @order.next
    #           flash[:error] = @order.errors.full_messages.join("\n")
    #           redirect_to(checkout_state_path(@order.state)) && return
    #         end
    #       end
    #     else
    #       unless @order.next
    #         flash[:error] = @order.errors.full_messages.join("\n")
    #         redirect_to(checkout_state_path(@order.state)) && return
    #       end
    #     end
    #
    #     if @order.completed?
    #       @current_order = nil
    #       flash.notice = Spree.t(:order_processed_successfully)
    #       flash['order_completed'] = true
    #       redirect_to completion_route
    #     else
    #       redirect_to checkout_state_path(@order.state)
    #     end
    #   else
    #     render :edit
    #   end
    # end

    def update
      if request.xhr?
        update_with_ajax
      else
        update_order
      end

    end

    def update_with_ajax
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
        end
      else
        render :edit
      end
    end

    def update_order
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to(checkout_state_path(@order.state)) && return
        end

        if @order.completed?
          @current_order = nil
          flash.notice = Spree.t(:order_processed_successfully)
          flash['order_completed'] = true
          redirect_to completion_route
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end

    def get_order_summary
      html = render_to_string :partial => "spree/checkout/order_summary"
      render :json => {:html_content => html} and return
    end

    def get_shipment_form
      html = render_to_string :partial => "spree/checkout/delivery"
      render :json => {:html_content => html} and return
    end

    def get_address_form
      bill_address_id = @order.bill_address.present? ? @order.bill_address.id : ''
      ship_address_id = @order.ship_address.present? ? @order.ship_address.id : ''
      render :json => {:bill_address => bill_address_id, :ship_address => ship_address_id, :email => @order.email} and return
    end

    def set_state_if_present
      @can_show_payment = @order.state == 'payment' ? true : false
      if params[:state]
        if @order.can_go_to_state?(params[:state]) && !skip_state_validation?
          unless request.xhr?
            redirect_to checkout_state_path(@order.state)
          end
        end
        @order.state = params[:state]
      end
    end

    def ensure_valid_state_lock_version
      if params[:order] && params[:order][:state_lock_version]
        @order.with_lock do
          unless @order.state_lock_version == params[:order].delete(:state_lock_version).to_i
            flash[:error] = Spree.t(:order_already_updated)
            unless request.xhr?
              redirect_to(checkout_state_path(@order.state)) && return
            end
          end
          @order.increment!(:state_lock_version)
        end
      end
    end
  end
end