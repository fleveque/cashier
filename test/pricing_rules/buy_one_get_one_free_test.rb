require_relative "../test_helper"
require_relative "../../lib/product"
require_relative "../../lib/pricing_rules/buy_one_get_one_free"

module PricingRules
  class BuyOneGetOneFreeTest < Minitest::Test
    def setup
      @product_for_price_rule = Product.new("P1", "Product 1", 10.0)
      @other_product = Product.new("P2", "Product 2", 5.0)
      @rule = BuyOneGetOneFree.new(@product_for_price_rule)
    end

    def test_initialization_fails_without_item
      assert_raises(ArgumentError) do
        BuyOneGetOneFree.new(nil)
      end
    end

    def test_initialization_fails_with_invalid_item
      assert_raises(ArgumentError) do
        BuyOneGetOneFree.new("Invalid Item")
      end
    end

    def test_calculate_discount_low_items
      assert_discount_for_quantity(0, 0.0)
      assert_discount_for_quantity(1, 0.0)
    end

    def test_calculate_discount_enough_items
      assert_discount_for_quantity(2, @product_for_price_rule.price)
      assert_discount_for_quantity(3, @product_for_price_rule.price)
      assert_discount_for_quantity(4, 2 * @product_for_price_rule.price)
    end

    def test_to_s
      expected_string = "Buy One Get One Free for #{@product_for_price_rule.code}"
      assert_equal expected_string, @rule.to_s
    end

    private

    def assert_discount_for_quantity(quantity, expected_discount)
      items = Array.new(quantity, @product_for_price_rule) + Array.new(10, @other_product)
      items.shuffle!
      assert_equal expected_discount, @rule.calculate_discount(items)
    end
  end
end
