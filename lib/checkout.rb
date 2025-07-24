class Checkout
  attr_reader :items, :pricing_rules, :total

  def initialize(pricing_rules = [])
    @items = []
    @pricing_rules = pricing_rules
    @total = 0.0
  end

  def scan(item)
    @items << item
    calculate_total
  end

  def to_s
    item_list = @items.map(&:to_s).join("\n")
    <<~CHECKOUT
      Items on cart:
      --------------
      #{item_list}
      Total: £#{format_price(@total)}
    CHECKOUT
  end

  private

  def format_price(price)
    format("%.2f", price)
  end

  def calculate_total
    @total = @items.sum(&:price)
  end
end
