module Helpers
  module PriceFormatter
    def format_price(price)
      format("%.2f", price)
    end

    def format_price_with_currency(price, currency = "£")
      "#{currency}#{format_price(price)}"
    end
  end
end
