require_relative "test_helper"
require_relative "../lib/checkout"
require_relative "../lib/product"
require_relative "../lib/pricing_rules/buy_one_get_one_free"
require_relative "../lib/pricing_rules/bulk_fixed_price"
require_relative "../lib/pricing_rules/bulk_percentage"

class CheckoutTest < Minitest::Test
  def setup
    @gr1 = Product.new("GR1", "Green tea", 3.11)
    @sr1 = Product.new("SR1", "Strawberries", 5.00)
    @cf1 = Product.new("CF1", "Coffee", 11.23)
    @rbogo = PricingRules::BuyOneGetOneFree.new(@gr1)
    @rbfp_price = 4.50
    @rbfp = PricingRules::BulkFixedPrice.new(@sr1, 3, @rbfp_price)
    @rbp_price_percentage = 2.0 / 3.0
    @rbp = PricingRules::BulkPercentage.new(@cf1, 3, @rbp_price_percentage)
    @checkout = Checkout.new
    @checkout_with_rules = Checkout.new([@rbogo, @rbfp, @rbp])
  end

  def test_initialization
    assert_instance_of Checkout, @checkout
    assert_empty @checkout.items
    assert_empty @checkout.pricing_rules
    assert_equal 0.0, @checkout.total
  end

  def test_initialization_with_invalid_pricing_rules
    assert_raises(ArgumentError) do
      Checkout.new("Invalid Pricing Rules")
    end
    assert_raises(ArgumentError) do
      Checkout.new([@rbogo, "Invalid Rule"])
    end
  end

  def test_scan_item
    @checkout.scan(@gr1)
    assert_includes @checkout.items, @gr1
    assert_equal 1, @checkout.items.size
  end

  def test_total_calculation
    @checkout.scan(@gr1)
    @checkout.scan(@sr1)
    @checkout.scan(@cf1)
    expected_total = @gr1.price + @sr1.price + @cf1.price
    assert_equal expected_total, @checkout.total
    assert_total_equals_base_total_minus_discount
  end

  # Requirement test pricing rules being applied
  # Specific tests for each pricing rule are in their respective test files
  def test_pricing_rules_acceptance_criteria_one
    @checkout_with_rules.scan(@gr1)
    @checkout_with_rules.scan(@sr1)
    @checkout_with_rules.scan(@gr1)
    @checkout_with_rules.scan(@gr1)
    @checkout_with_rules.scan(@cf1)

    expected_total = (@gr1.price * 2) + @sr1.price + @cf1.price
    assert_equal expected_total, @checkout_with_rules.total
    assert_total_equals_base_total_minus_discount
  end

  def test_pricing_rules_acceptance_criteria_two
    @checkout_with_rules.scan(@gr1)
    @checkout_with_rules.scan(@gr1)

    expected_total = @gr1.price
    assert_equal expected_total, @checkout_with_rules.total
    assert_total_equals_base_total_minus_discount
  end

  def test_pricing_rules_acceptance_criteria_three
    @checkout_with_rules.scan(@sr1)
    @checkout_with_rules.scan(@sr1)
    @checkout_with_rules.scan(@gr1)
    @checkout_with_rules.scan(@sr1)

    expected_total = (@rbfp_price * 3) + @gr1.price
    assert_equal expected_total, @checkout_with_rules.total
    assert_total_equals_base_total_minus_discount
  end

  def test_pricing_rules_acceptance_criteria_four
    @checkout_with_rules.scan(@gr1)
    @checkout_with_rules.scan(@cf1)
    @checkout_with_rules.scan(@sr1)
    @checkout_with_rules.scan(@cf1)
    @checkout_with_rules.scan(@cf1)

    expected_total = ((@cf1.price * @rbp_price_percentage) * 3) + @gr1.price + @sr1.price
    assert_equal expected_total, @checkout_with_rules.total
    assert_total_equals_base_total_minus_discount
  end

  private

  def assert_total_equals_base_total_minus_discount
    assert_equal @checkout_with_rules.total,
                 (@checkout_with_rules.base_total - @checkout_with_rules.discount).round(2)
  end
end
