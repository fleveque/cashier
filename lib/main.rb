#!/usr/bin/env ruby

require_relative "checkout"
require_relative "product"
require_relative "pricing_rules/buy_one_get_one_free"
require_relative "pricing_rules/bulk_fixed_price"
require_relative "pricing_rules/bulk_percentage"
require_relative "helpers/price_formatter"

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def main
  puts "Cashier System"
  puts "==============\n\n"

  # Add products
  gr1 = Product.new("GR1", "Green tea", 3.11)
  sr1 = Product.new("SR1", "Strawberries", 5.00)
  cf1 = Product.new("CF1", "Coffee", 11.23)

  puts "Available products:"
  puts "-------------------"
  puts gr1
  puts sr1
  puts cf1

  # Add pricing rules
  pr1 = PricingRules::BuyOneGetOneFree.new(gr1)
  pr2 = PricingRules::BulkFixedPrice.new(sr1, 3, 4.50)
  pr3 = PricingRules::BulkPercentage.new(cf1, 3, 2.0 / 3.0)

  puts "\n\n"
  puts "Available pricing rules:"
  puts "------------------------"
  puts pr1
  puts pr2
  puts pr3
  puts "\n\n"

  puts "Checkout with pricing rules (1):"
  puts "--------------------------------\n\n"

  # Initialize checkout with pricing rules
  co = Checkout.new([pr1, pr2, pr3])

  co.scan(gr1)
  co.scan(sr1)
  co.scan(gr1)
  co.scan(gr1)
  co.scan(cf1)
  puts
  puts co

  puts "\n\n"

  puts "Checkout with pricing rules (2):"
  puts "--------------------------------\n\n"

  # Initialize checkout with pricing rules
  co = Checkout.new([pr1, pr2, pr3])

  co.scan(gr1)
  co.scan(gr1)
  puts
  puts co

  puts "\n\n"

  puts "Checkout with pricing rules (3):"
  puts "--------------------------------\n\n"

  # Initialize checkout with pricing rules
  co = Checkout.new([pr1, pr2, pr3])

  co.scan(sr1)
  co.scan(sr1)
  co.scan(gr1)
  co.scan(sr1)
  puts
  puts co

  puts "\n\n"

  puts "Checkout with pricing rules (4):"
  puts "--------------------------------\n\n"

  # Initialize checkout with pricing rules
  co = Checkout.new([pr1, pr2, pr3])

  co.scan(gr1)
  co.scan(cf1)
  co.scan(sr1)
  co.scan(cf1)
  co.scan(cf1)
  puts
  puts co
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

# Run main if this file is executed directly
main if __FILE__ == $PROGRAM_NAME
