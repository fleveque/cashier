module PricingRules
  class Base
    def initialize(item)
      raise ArgumentError, "Invalid item" unless item.is_a?(Product)

      @item = validate_item(item)
    end

    def calculate_discount(items)
      raise NotImplementedError, "Subclasses must implement calculate_discount"
    end

    def to_s
      "#{self.class.name} for #{@item.code}"
    end

    private

    def validate_item(item)
      raise ArgumentError, "Invalid item" unless item.is_a?(Product)

      item
    end
  end
end
