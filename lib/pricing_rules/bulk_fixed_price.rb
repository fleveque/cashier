require_relative "../pricing_rules/base"
require_relative "../helpers/price_formatter"

module PricingRules
  class BulkFixedPrice < PricingRules::Base
    include Helpers::PriceFormatter

    def initialize(item, minimum_quantity, discounted_price)
      super(item)
      @minimum_quantity = validate_minimum_quantity(minimum_quantity)
      @discounted_price = validate_discounted_price(discounted_price)
    end

    def calculate_discount(items)
      matching = items.select { |item| item.code == @item.code }
      return 0.0 if matching.empty? || matching.count < @minimum_quantity

      discount = (matching.first.price - @discounted_price) * matching.count
      discount.round(2)
    end

    def to_s
      "Bulk Fixed Price for #{@item.code} " \
        "(min: #{@minimum_quantity}, price: #{format_price_with_currency(@discounted_price)})"
    end

    private

    def validate_minimum_quantity(quantity)
      unless quantity.is_a?(Integer) && quantity.positive?
        raise ArgumentError,
              "Minimum quantity must be a positive integer"
      end

      quantity
    end

    def validate_discounted_price(price)
      if price.nil? || !price.is_a?(Numeric) || price.negative?
        raise ArgumentError,
              "Discounted price must be a valid number"
      end

      Float(price)
    rescue ArgumentError => e
      unless e.message.include?("invalid value for Float")
        raise ArgumentError,
              "Discounted price must be a valid number"
      end

      raise e
    end
  end
end
