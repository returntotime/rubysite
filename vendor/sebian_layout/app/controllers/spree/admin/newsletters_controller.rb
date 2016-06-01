module Spree
  module Admin
    class NewslettersController < Spree::Admin::BaseController

      def edit
        if Spree::Config[:constant_contact_api_key].present? && Spree::Config[:constant_contact_access_token].present?
          cc = ConstantContact::Api.new(Spree::Config[:constant_contact_api_key], Spree::Config[:constant_contact_access_token])
          @lists = cc.get_lists
        end
      end

      def update
        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        flash[:success] = Spree.t(:successfully_updated, resource: "Newsletter Popup Settings")
        redirect_to edit_admin_newsletters_path
      end

      def auth
        begin
          redirect_url = cookies[:redirect_url].present? ? cookies[:redirect_url] : request.original_url
          @oauth = ConstantContact::Auth::OAuth2.new(
              :api_key => Spree::Config[:constant_contact_api_key],
              :api_secret => Spree::Config[:constant_contact_api_secret],
              :redirect_url => redirect_url
          )
          if cookies[:redirect_url].present? && cookies[:redirect_url] != request.original_url
            cookies.delete redirect_url
          else
            cookies[:redirect_url] = redirect_url
          end

          @error = params[:error]
          @user = params[:username]
          @code = params[:code]

          if @code.present?
            response = @oauth.get_access_token(@code)
            if response.present?
              token = response['access_token']
              Spree::Config[:constant_contact_access_token] = token if Spree::Config.has_preference? :constant_contact_access_token
            end
            redirect_to edit_admin_newsletters_path
          else
            # if not code param is provided redirect into the OAuth flow
            redirect_to @oauth.get_authorization_url and return
          end
        rescue Exception => e
          flash[:error] = e.message
          redirect_to edit_admin_newsletters_path
        end
      end
    end
  end
end