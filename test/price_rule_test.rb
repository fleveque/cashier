class PriceRuleTest < Minitest::Test
  def setup
    @checkout = Checkout.new
    @gr1 = GroceryItem.new("Grocery Item 1", 10.00)
    @sr1 = StrawberryItem.new("Strawberry Item 1", 5.00)
    @cf1 = CoffeeItem.new("Coffee Item 1", 15.00)
  end
end
