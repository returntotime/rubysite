namespace :zones do
  task :seed_checkout_zone_us => :environment do
    usa_zone = find_or_create_usa_zone
    find_or_create_shipping_method([usa_zone])
  end
end

def find_or_create_usa_zone
  unless zone = Spree::Zone.find_by(name: "United States")
    zone = Spree::Zone.new
    zone.name = "United States"
    zone.description = "United States"
    zone.kind = "country"
    zone.save!

    us_country = Spree::Country.find_by(iso3: "USA")
    us_country.zone_members.find_or_create_by(zone_id: zone.id)
  end
  zone
end

def find_or_create_shipping_method(zones)
  default_category = Spree::ShippingCategory.first

  unless shipping_method = Spree::ShippingMethod.first #find_by(name: "Shipping ( UPS Ground )\t")
    shipping_method = Spree::ShippingMethod.new
    shipping_method.name = "Shipping ( UPS Ground )"
    shipping_method.shipping_categories = Spree::ShippingCategory.all
    shipping_method.calculator_type = "Spree::Calculator::Shipping::FlatRate"
    shipping_method.save!
  end

  unless calculator = shipping_method.calculator
    calculator = shipping_method.calculator.new
  end

  calculator.type = "Spree::Calculator::Shipping::FlatRate"
  calculator.preferred_amount = 0
  calculator.preferred_currency = "USD"
  calculator.save!

  shipping_method.shipping_method_categories.find_or_create_by(shipping_category_id: default_category.id)

  shipping_method.zones = zones
  shipping_method.save!
end