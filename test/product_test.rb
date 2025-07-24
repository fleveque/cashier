require_relative 'test_helper'
require_relative '../lib/product'

class ProductTest < Minitest::Test
  def setup
    @product = Product.new("P1", "Product 1", 10.0)
  end

  def test_initialization
    assert_equal "P1", @product.code
    assert_equal "Product 1", @product.name
    assert_equal 10.0, @product.price
  end

  def test_name_validation
    assert_raises(ArgumentError) do
      Product.new("P2", nil, 5.0)
    end
    assert_raises(ArgumentError) do
      Product.new("P3", "", 5.0)
    end
  end

  def test_code_validation
    assert_raises(ArgumentError) do
      Product.new(nil, "Product 2", 5.0)
    end
    assert_raises(ArgumentError) do
      Product.new("", "Product 3", 5.0)
    end
  end

  def test_price_validation
    assert_raises(ArgumentError) do
      Product.new("P4", "Product 4", nil)
    end
    assert_raises(ArgumentError) do
      Product.new("P5", "Product 5", -1.0)
    end
    assert_raises(ArgumentError) do
      Product.new("P6", "Product 6", "invalid")
    end
  end

  def test_to_s
    test_cases = [
      { price: 10.0, expected: "Product 1 (P1): £10.00" },
      { price: 5.5, expected: "Product 1 (P1): £5.50" },
      { price: 0.9999, expected: "Product 1 (P1): £1.00" }
    ]

    test_cases.each do |test_case|
      @product.price = test_case[:price]
      assert_equal test_case[:expected], @product.to_s
    end
  end
end
