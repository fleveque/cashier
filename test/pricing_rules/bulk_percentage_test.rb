require_relative "../test_helper"
require_relative "../../lib/product"
require_relative "../../lib/pricing_rules/bulk_percentage"

module PricingRules
  class BulkPercentageTest < Minitest::Test
    def setup
      @product_for_price_rule = Product.new("P1", "Product 1", 10.0)
      @other_product = Product.new("P2", "Product 2", 5.0)
      @rule = PricingRules::BulkPercentage.new(@product_for_price_rule, 3, 0.8)
    end

    def test_invalid_arguments
      invalid_arguments.each do |args|
        assert_raises(ArgumentError) do
          PricingRules::BulkPercentage.new(*args)
        end
      end
    end

    def test_calculate_discount_low_items
      assert_discount_for_quantity(0, 0.0)
      assert_discount_for_quantity(1, 0.0)
      assert_discount_for_quantity(2, 0.0)
    end

    def test_calculate_discount_enough_items
      assert_discount_for_quantity(3, 6.0)
      assert_discount_for_quantity(4, 8.0)
      assert_discount_for_quantity(5, 10.0)
    end

    def test_to_s
      expected_string = "Bulk Percentage for #{@product_for_price_rule.code} (min: 3, percentage: 80.00%)"
      assert_equal expected_string, @rule.to_s
    end

    private

    def invalid_arguments
      [
        [nil, 3, 8.0],
        ["Invalid Item", 3, 8.0],
        [@product_for_price_rule, nil, 8.0],
        [@product_for_price_rule, -1, nil],
        [@product_for_price_rule, "invalid", 8.0],
        [@product_for_price_rule, 3, nil],
        [@product_for_price_rule, 3, -1.0],
        [@product_for_price_rule, 3, 0.0],
        [@product_for_price_rule, 3, 1.1],
        [@product_for_price_rule, 3, "invalid"]
      ]
    end

    def assert_discount_for_quantity(quantity, expected_discount)
      items = Array.new(quantity, @product_for_price_rule) + Array.new(10, @other_product)
      items.shuffle!
      assert_equal expected_discount, @rule.calculate_discount(items)
    end
  end
end
