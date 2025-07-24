require_relative "../test_helper"
require_relative "../../lib/helpers/price_formatter"

module Helpers
  class PriceFormatterTest < Minitest::Test
    # Create a test class that includes the helper module
    class TestClass
      include Helpers::PriceFormatter
    end

    def setup
      @formatter = TestClass.new
    end

    def test_format_price_with_two_decimal_places
      assert_equal "3.11", @formatter.format_price(3.11)
      assert_equal "5.00", @formatter.format_price(5.0)
      assert_equal "11.23", @formatter.format_price(11.234)
    end

    def test_format_price_rounds_to_two_decimal_places
      assert_equal "3.12", @formatter.format_price(3.115)
      assert_equal "3.11", @formatter.format_price(3.114)
    end

    def test_format_price_handles_zero
      assert_equal "0.00", @formatter.format_price(0)
      assert_equal "0.00", @formatter.format_price(0.0)
    end

    def test_format_price_with_currency_default_pound
      assert_equal "£3.11", @formatter.format_price_with_currency(3.11)
      assert_equal "£5.00", @formatter.format_price_with_currency(5.0)
    end

    def test_format_price_with_currency_custom_symbol
      assert_equal "$3.11", @formatter.format_price_with_currency(3.11, "$")
      assert_equal "€5.00", @formatter.format_price_with_currency(5.0, "€")
      assert_equal "¥100.00", @formatter.format_price_with_currency(100, "¥")
    end

    def test_format_price_with_currency_empty_symbol
      assert_equal "3.11", @formatter.format_price_with_currency(3.11, "")
    end
  end
end
