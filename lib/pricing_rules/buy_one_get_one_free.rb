require_relative "../pricing_rules/base"

module PricingRules
  class BuyOneGetOneFree < PricingRules::Base
    def calculate_discount(items)
      items.select { |item| item.code == @item.code }.tap do |matching|
        return 0.0 if matching.empty? || matching.count < 2

        free_items = matching.count / 2
        return free_items * matching.first.price
      end
    end

    def to_s
      "Buy One Get One Free for #{@item.code}"
    end
  end
end
