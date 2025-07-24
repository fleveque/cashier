require_relative "test_helper"
require_relative "../lib/checkout"
require_relative "../lib/product"
require_relative "../lib/pricing_rules/buy_one_get_one_free"
require_relative "../lib/pricing_rules/bulk_fixed_price"
require_relative "../lib/pricing_rules/bulk_percentage"

class CheckoutTest < Minitest::Test
  def setup
    @checkout = Checkout.new
    @gr1 = Product.new("GR1", "Green tea", 3.11)
    @sr1 = Product.new("SR1", "Strawberries", 5.00)
    @cf1 = Product.new("CF1", "Coffee", 11.23)
    @rbogo = PricingRules::BuyOneGetOneFree.new(@gr1)
    @rbfp = PricingRules::BulkFixedPrice.new(@sr1, 3, 4.50)
    @rbp = PricingRules::BulkPercentage.new(@cf1, 3, 1.0 / 3.0)
  end

  def test_initialization
    assert_instance_of Checkout, @checkout
    assert_empty @checkout.items
    assert_empty @checkout.pricing_rules
    assert_equal 0.0, @checkout.total
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
  end

  # Test pricing rules being applied
  # Specific tests for each pricing rule are in their respective test files
  def test_pricing_rules_acceptance_criteria_one
    @checkout = Checkout.new([@rbogo, @rbfp, @rbp])

    @checkout.scan(@gr1)
    @checkout.scan(@sr1)
    @checkout.scan(@gr1)
    @checkout.scan(@gr1)
    @checkout.scan(@cf1)

    expected_total = (@gr1.price * 2) + @sr1.price + @cf1.price
    assert_equal expected_total, @checkout.total
  end

  def test_pricing_rules_acceptance_criteria_two
    @checkout = Checkout.new([@rbogo, @rbfp, @rbp])

    @checkout.scan(@gr1)
    @checkout.scan(@gr1)

    expected_total = @gr1.price
    assert_equal expected_total, @checkout.total
  end

  def test_pricing_rules_acceptance_criteria_three
    skip "This test is not implemented yet"
  end

  def test_pricing_rules_acceptance_criteria_four
    skip "This test is not implemented yet"
  end
end
