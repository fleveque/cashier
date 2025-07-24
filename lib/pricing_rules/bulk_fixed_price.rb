require_relative "../pricing_rules/base"
require_relative "../helpers/price_formatter"

module PricingRules
  class BulkFixedPrice < PricingRules::Base
    include Helpers::PriceFormatter

    def initialize(item, minimum_quantity, discounted_price)
      super(item)
      @minimum_quantity = minimum_quantity
      @discounted_price = discounted_price
    end

    def to_s
      "Bulk Fixed Price for #{@item.code} " \
        "(min: #{@minimum_quantity}, price: #{format_price_with_currency(@discounted_price)})"
    end
  end
end
