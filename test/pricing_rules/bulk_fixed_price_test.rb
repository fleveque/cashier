require_relative "../test_helper"
require_relative "../../lib/product"
require_relative "../../lib/pricing_rules/bulk_fixed_price"

module PricingRules
  class BulkFixedPriceTest < Minitest::Test
    def setup
      @product_for_price_rule = Product.new("P1", "Product 1", 10.0)
      @other_product = Product.new("P2", "Product 2", 5.0)
      @rule = PricingRules::BulkFixedPrice.new(@product_for_price_rule, 3, 8.0)
    end

    def test_initialization_fails_with_wrong_arguments
      invalid_arguments.each do |item, min_qty, discounted_price|
        assert_raises(ArgumentError) do
          BulkFixedPrice.new(item, min_qty, discounted_price)
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
