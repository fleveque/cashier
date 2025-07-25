require_relative "../test_helper"
require_relative "../../lib/product"
require_relative "../../lib/pricing_rules/base"

module PricingRules
  class BaseTest < Minitest::Test
    def setup
      @product = Product.new("P1", "Product 1", 10.0)
      @pricing_rule = Base.new(@product)
    end

    def test_initialization_fails_without_item
      assert_raises(ArgumentError) do
        Base.new(nil)
      end
    end

    def test_initialization_fails_with_invalid_item
      assert_raises(ArgumentError) do
        Base.new("Invalid Item")
      end
    end

    def test_calculate_discount_raises_not_implemented_error
      assert_raises(NotImplementedError) do
        @pricing_rule.calculate_discount([])
      end
    end
  end
end
