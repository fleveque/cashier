require_relative "test_helper"
require_relative "../lib/checkout"
require_relative "../lib/product"

class CheckoutTest < Minitest::Test
  def setup
    @checkout = Checkout.new
    @gr1 = Product.new("GR1", "Green tea", 3.11)
    @sr1 = Product.new("SR1", "Strawberries", 5.00)
    @cf1 = Product.new("CF1", "Coffee", 11.23)
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
end
