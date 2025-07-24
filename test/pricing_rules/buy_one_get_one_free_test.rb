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

    def test_calculate_discount_no_items
      assert_discount_for_quantity(0, 0.0)
    end

    def test_calculate_discount_one_item
      assert_discount_for_quantity(1, 0.0)
    end

    def test_calculate_discount_two_items
      assert_discount_for_quantity(2, @product_for_price_rule.price)
    end

    def test_calculate_discount_three_items
      assert_discount_for_quantity(3, @product_for_price_rule.price)
    end

    def test_calculate_discount_four_items
      assert_discount_for_quantity(4, 2 * @product_for_price_rule.price)
    end

    private

    def assert_discount_for_quantity(quantity, expected_discount)
      items = Array.new(quantity, @product_for_price_rule) + Array.new(10, @other_product)
      items.shuffle!
      assert_equal expected_discount, @rule.calculate_discount(items)
    end
  end
end
