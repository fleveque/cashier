require_relative "../test_helper"
require_relative "../../lib/product"
require_relative "../../lib/pricing_rules/bulk_percentage"

module PricingRules
  class BulkPercentageTest < Minitest::Test
    def setup
      @product_for_price_rule = Product.new("P1", "Product 1", 10.0)
      @other_product = Product.new("P2", "Product 2", 5.0)
      @rule = PricingRules::BulkPercentage.new(@product_for_price_rule, 3, 0.2)
    end
  end
end
