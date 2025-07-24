#!/usr/bin/env ruby

require_relative 'product'

def main
  puts "Cashier System"
  puts "=============="
  
  # Example usage
  green_tea = Product.new("GR1", "Green tea", 3.11)
  strawberries = Product.new("SR1", "Strawberries", 5.00)
  coffee = Product.new("CF1", "Coffee", 11.23)
  
  puts "Available products:"
  puts green_tea
  puts strawberries
  puts coffee
  
  puts "\nCheckout system ready!"
end

# Run main if this file is executed directly
main if __FILE__ == $0
