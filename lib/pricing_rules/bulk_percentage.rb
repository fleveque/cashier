require_relative "../pricing_rules/base"

module PricingRules
  class BulkPercentage < PricingRules::Base
    def initialize(item, min_quantity, percentage)
      super(item)
      @min_quantity = min_quantity
      @percentage = percentage
    end

    def to_s
      "Bulk Percentage for #{@item.code} (min: #{@min_quantity}, discount: #{format_percentage})"
    end

    private

    def format_percentage
      "#{format("%.2f", @percentage * 100)}%"
    end
  end
end
