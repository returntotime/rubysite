class Spree::ContactUs::ContactsController < Spree::StoreController

  helper "spree/products"
  def create
    begin
      @contact = Spree::ContactUs::Contact.new(params[:contact_us_contact])
      if @contact.save
        if Spree::ContactUs::Config.contact_tracking_message.present?
          flash[:contact_tracking] = Spree::ContactUs::Config.contact_tracking_message
        end
        msg = ''
        if params[:subcribe].to_i == 1
          if Spree::Config[:mailchimp_enabled]
            msg = mailchimp_contact
          else
            msg = constant_contact
          end
        end
        redirect_to(spree.new_contact_path, :notice => Spree.t('contact_us.notices.success') + "#{(msg != '') ? ' But ' + msg['message'] : ''}")
      else
        render :new
      end
    rescue Exception => e
      redirect_to(spree.new_contact_path, :notice => e.message)
    end

  end

  def new
    @contact = Spree::ContactUs::Contact.new
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

  private

  def mailchimp_contact
    msg = ''
    begin
      Gibbon::Request.api_key = Spree::Config[:mailchimp_api_key]
      gb = Gibbon::Request.new
      list_id = Spree::Config[:mailchimp_list_id]
      email = params[:contact_us_contact][:email]
      gb.lists(list_id).members.create(body: {email_address: email, status: "subscribed", merge_fields: {FNAME:  params[:contact_us_contact][:name]}})
      msg[:type => 'success', :message => Spree::Config[:newsletter_success_message]]
    rescue Gibbon::MailChimpError => e
      if e.body["title"] == "Member Exists"
        msg[:type => 'warning', :message => "#{params[:contact_us_contact][:email]} is already a list member"]
      else
        msg[:type => 'warning', :message => e.body["detail"]]
      end
    rescue Gibbon::GibbonError => e
      msg[:type => 'warning', :message => e.message]
    end
    msg
  end


  def constant_contact
    msg = ''
    if Spree::Config[:constant_contact_access_token].present? && Spree::Config[:constant_contact_api_key].present?
      constant = ConstantContact::Api.new(Spree::Config[:constant_contact_api_key], Spree::Config[:constant_contact_access_token])
      list = constant.get_list(Spree::Config[:constant_contact_list_id])
      if list.present?
        begin
          new_contact = ConstantContact::Components::Contact.new
          new_contact.add_email(ConstantContact::Components::EmailAddress.new(params[:contact_us_contact][:email]))
          new_contact.add_list(list)
          new_contact.first_name = params[:contact_us_contact][:name]
          new_contact.last_name = ''
          constant.add_contact( new_contact ).to_json
          msg[:type => 'success', :message => Spree::Config[:newsletter_success_message]]
        rescue => e
          if e.message.to_s.downcase == '409 conflict'
            msg[:type => 'warning', :message => "#{params[:email_subcribe]} is already a list member"]
          end
        end
      else
        msg[:type => 'warning', :message => "Contact list has not been created!"]
      end
    else
      msg[:type => 'warning', :message => "Site can not connect to email service!"]
    end
    msg
  end

  def accurate_title
    Spree.t(:contact_us_title)
  end

end
