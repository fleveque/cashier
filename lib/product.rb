class Product
  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code = validate_presence(code, "Code")
    @name = validate_presence(name, "Name")
    @price = validate_price(price)
  end

  def price=(new_price)
    @price = validate_price(new_price)
  end

  def to_s
    "#{@name} (#{@code}): £#{format_price(price)}"
  end

  private

  def validate_presence(value, field_name)
    raise ArgumentError, "#{field_name} cannot be nil or empty" if value.nil? || value.to_s.strip.empty?

    value
  end

  def validate_price(price)
    raise ArgumentError, "Price cannot be nil" if price.nil?

    numeric_price = Float(price)
    raise ArgumentError, "Price cannot be negative" if numeric_price.negative?

    numeric_price
  rescue ArgumentError => e
    raise e if e.message.include?("cannot be")

    raise ArgumentError, "Price must be a valid number"
  end

  def format_price(price)
    format("%.2f", price)
  end
end
