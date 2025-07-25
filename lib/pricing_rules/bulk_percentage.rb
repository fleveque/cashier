require_relative "../pricing_rules/base"

module PricingRules
  class BulkPercentage < PricingRules::Base
    def initialize(item, minimum_quantity, percentage)
      super(item)
      @minimum_quantity = minimum_quantity(minimum_quantity)
      @percentage = validate_percentage(percentage)
    end

    def calculate_discount(items)
      matching = items.select { |item| item.code == @item.code }
      return 0.0 if matching.empty? || matching.count < @minimum_quantity

      discount = (matching.first.price * (1 - @percentage)) * matching.count
      discount.round(2)
    end

    def to_s
      "Bulk Percentage for #{@item.code} (min: #{@min_quantity}, percentage: #{format_percentage})"
    end

    private

    def minimum_quantity(minimum_quantity)
      unless minimum_quantity.is_a?(Integer) && minimum_quantity.positive?
        raise ArgumentError,
              "Minimum quantity must be a positive integer"
      end

      minimum_quantity
    end

    def validate_percentage(percentage)
      unless percentage.is_a?(Float) && percentage > 0.0 && percentage <= 1.0
        raise ArgumentError,
              "Percentage must be a float between 0 and 1 (exclusive of 0)"
      end

      percentage
    end

    def format_percentage
      "#{format("%.2f", @percentage * 100)}%"
    end
  end
end
