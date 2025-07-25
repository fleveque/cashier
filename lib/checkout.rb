require_relative "helpers/price_formatter"

class Checkout
  include Helpers::PriceFormatter

  attr_reader :items, :pricing_rules, :base_total, :discount

  def initialize(pricing_rules = [])
    @items = []
    @pricing_rules = validate_pricing_rules(pricing_rules)
    @base_total = 0.0
    @discount = 0.0
  end

  def scan(item)
    @items << item
    @base_total = calculate_total
    @discount = calculate_discount
  end

  def total
    (@base_total - @discount).round(2)
  end

  def to_s
    item_list = @items.map(&:to_s).join("\n")
    <<~CHECKOUT
      Items on cart:
      --------------
      #{item_list}
      --------------
      Base Total: #{format_price_with_currency(@base_total)}
      Discounts Applied: #{format_price_with_currency(@discount)}
      --------------
      Total: #{format_price_with_currency(total)}
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
    @items.sum(&:price).round(2)
  end

  def calculate_discount
    total_discount = @pricing_rules.sum { |rule| rule.calculate_discount(@items) }
    total_discount.round(2)
  end
end
