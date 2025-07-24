require_relative "../pricing_rules/base"

module PricingRules
  class BuyOneGetOneFree < PricingRules::Base
    def calculate_discount(items)
      matching = matching_items(items)
      return 0.0 if matching.empty?

      # Calculate discount based on the number of matching items
      discount = 0.0
      matching.each_slice(2) do |pair|
        discount += pair.first.price
      end
      discount
    end

    def to_s
      "Buy One Get One Free for #{@item.code}"
    end
  end
end
