require_relative "../pricing_rules/base"

module PricingRules
  class BuyOneGetOneFree < PricingRules::Base
    def calculate_discount(items)
      matching = items.select { |item| item.code == @item.code }
      return 0.0 if matching.empty? || matching.count < 2

      free_items = matching.count / 2
      discount = free_items * matching.first.price
      discount.round(2)
    end

    def to_s
      "Buy One Get One Free for #{@item.code}"
    end
  end
end
