module PricingRules
  class Base
    attr_reader :product_code

    def initialize(item)
      @item = item
    end

    def calculate_discount
      raise NotImplementedError, "Subclasses must implement calculate_discount"
    end

    def to_s
      "#{self.class.name} for #{@item.code}"
    end
  end
end
