require_relative "helpers/price_formatter"

class Checkout
  include Helpers::PriceFormatter

  attr_reader :items, :pricing_rules, :total

  def initialize(pricing_rules = [])
    @items = []
    @pricing_rules = validate_pricing_rules(pricing_rules)
    @total = 0.0
  end

  def scan(item)
    @items << item
    @total = calculate_total
  end

  def to_s
    item_list = @items.map(&:to_s).join("\n")
    <<~CHECKOUT
      Items on cart:
      --------------
      #{item_list}
      Total: #{format_price_with_currency(@total)}
    CHECKOUT
  end

  private

  def validate_pricing_rules(rules)
    raise ArgumentError, "Pricing rules must be an array" unless rules.is_a?(Array)

    rules.each do |rule|
      unless rule.is_a?(PricingRules::Base)
        raise ArgumentError, "Each pricing rule must be an instance of PricingRules::Base"
      end
    end

    rules
  end

  def calculate_total
    base_total = @items.sum(&:price)
    total_discount = @pricing_rules.sum { |rule| rule.calculate_discount(@items) }
    final_total = base_total - total_discount
    final_total.round(2)
  end
end
