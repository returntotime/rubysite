Spree::HomeController.class_eval do
  before_filter :get_brands, :only => [:index]

  def index
    @body_id = "homepage"
    @searcher = build_searcher(params.merge(include_images: true))
    @popular_weekly_products = Spree::Product.popular_weekly.limit(4)
    @love_design_products = Spree::Product.in_this_look.limit(5)
    @new_arrival_taxons = Spree::Taxon.joins(:classifications).where("product_id IN (#{Spree::Product.new_arrival.enabled.select(:id).to_sql})").distinct("taxon_id")
    @new_collections = Spree::Taxonomy.featured
    @store = Spree::Store.first
    #@blog_entries = Spree::BlogEntry.show_on_homepage.limit(3)
    @blog_categories = Spree::BlogEntry.tag_counts_on(:categories).where(:featured => true).limit(3)

    if cookies[:subscribing].present?
      @subscribing = true
      cookies.delete :subscribing
    end
  end

  def subscribe
      if params[:email_subcribe].present?
        if Spree::Config[:mailchimp_enabled]
          mailchimp_contact
        else
          constant_contact
        end
      end
      redirect_to root_path
  end

  private

  def mailchimp_contact
    begin
      Gibbon::Request.api_key = Spree::Config[:mailchimp_api_key]
      gibbon = Gibbon::Request.new
      list_id = Spree::Config[:mailchimp_list_id]
      gibbon.lists(list_id).members.create(body: {email_address: params[:email_subcribe], status: "subscribed"})
      # gb = gibbon.lists(list_id).members.create(body: {
      #                                                   email_address: params[:email_subcribe],
      #                                                   status: "subscribed"
      #                                                   # merge_fields: {
      #                                                   #      FNAME: params[:first_name],
      #                                                   #      LNAME: params[:last_name]}
      #  })


      flash[:success] = Spree::Config[:newsletter_success_message]
      cookies[:subscribing] = true
        # render :json => { flash_type: 'alert-success', message: Spree::Config[:newsletter_success_message] }

    rescue Gibbon::MailChimpError => e
      if e.body['title'] == "Member Exists"
        msg = "#{params[:email_subcribe]} is already a list member"
      else
        msg = e.body["detail"]
      end
      flash[:error] = msg
    rescue Gibbon::GibbonError => e
      flash[:error] = e.message
    end
  end

  def constant_contact
    if Spree::Config[:constant_contact_access_token].present? && Spree::Config[:constant_contact_api_key].present?
      constant = ConstantContact::Api.new(Spree::Config[:constant_contact_api_key], Spree::Config[:constant_contact_access_token])
      list = constant.get_list(Spree::Config[:constant_contact_list_id])
      if list.present?
        begin
          new_contact = ConstantContact::Components::Contact.new
          new_contact.add_email(ConstantContact::Components::EmailAddress.new(params[:email_subcribe]))
          new_contact.add_list(list)
          new_contact.first_name = ''
          new_contact.last_name = ''
          constant.add_contact( new_contact ).to_json
          flash[:success] = Spree::Config[:newsletter_success_message]
          cookies[:subscribing] = true
        rescue => e
          if e.message.to_s.downcase == '409 conflict'
            flash[:warning] = "#{params[:email_subcribe]} is already a list member"
          end
        end
      else
        flash[:warning] = "Contact list has not been created!"
      end
    else
      flash[:warning] = "Site can not connect to email service!"
    end
  end

  def get_brands
    @brands = Spree::Taxonomy.brand
  end

end
