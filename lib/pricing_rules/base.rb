module PricingRules
  class Base
    def initialize(item)
      @item = item
    end

    def calculate_discount(items)
      raise NotImplementedError, "Subclasses must implement calculate_discount"
    end

    def to_s
      "#{self.class.name} for #{@item.code}"
    end
  end
end
