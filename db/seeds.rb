if Spree::Product.gift_cards.count == 0
  shipping_category = Spree::ShippingCategory.create(name: 'Gift Card')
  product = Spree::Product.new(available_on: Time.now, name: "Gift Card", is_gift_card: true, slug: 'gift-card', price: 0, shipping_category_id: shipping_category.id)
  puts "\tCreating default gift card..."
  option_type = Spree::OptionType.new(name: "is-gift-card", presentation: "Value")
  product.option_types << option_type
  [100,125,150,175,200,250,300,350,400,450,499,550,600,750,1000,2000,4999,6499].each do |value|
    option_value = Spree::OptionValue.new(name: value, presentation: "$#{value}")
    option_value.option_type = option_type
    opts = { price: value.to_i, sku: "GiftCard-#{value}" }
    variant = Spree::Variant.new(opts)
    variant.option_values << option_value
    product.variants << variant
  end
  product.save
end
