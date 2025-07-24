#!/usr/bin/env ruby

require_relative "checkout"
require_relative "product"

# rubocop:disable Metrics/MethodLength
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

  # Initialize checkout
  co = Checkout.new

  # Scan items
  puts "\nScanning items...\n\n"
  co.scan(gr1)
  co.scan(sr1)
  co.scan(cf1)
  puts
  puts co
  puts
  puts "Total price: £#{co.total}"
end
# rubocop:enable Metrics/MethodLength

# Run main if this file is executed directly
main if __FILE__ == $PROGRAM_NAME
