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
    calculate_total
    apply_pricing_rules
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
    @total = @items.sum(&:price)
  end

  def apply_pricing_rules
    @pricing_rules.each do |rule|
      discount = rule.calculate_discount(@items)
      @total -= discount
    end
  end
end
