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
    if value.nil? || value.to_s.strip.empty?
      raise ArgumentError, "#{field_name} cannot be nil or empty"
    end
    value
  end

  def validate_price(price)
    if price.nil?
      raise ArgumentError, "Price cannot be nil"
    end
    
    numeric_price = Float(price)
    if numeric_price < 0
      raise ArgumentError, "Price cannot be negative"
    end
    
    numeric_price
  rescue ArgumentError => e
    raise e if e.message.include?("cannot be")
    raise ArgumentError, "Price must be a valid number"
  end

  def format_price(price)
    '%.2f' % price
  end
end
