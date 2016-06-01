[:footer_logo, :logo,:instagram_client_id, :favicon].each do |permit_attr|
  Spree::PermittedAttributes.store_attributes << permit_attr
end

[:extenal_link].each do |permit_attr|
  Spree::PermittedAttributes.taxon_attributes << permit_attr
end

[:firstname, :lastname].each do |permit_attr|
  Spree::PermittedAttributes.user_attributes << permit_attr
end