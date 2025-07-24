# TLDR;

## Run tests:
   ```bash
   rake test
   # or run individual test files
   ruby -Ilib:test test/product_test.rb
   ```

## Run sample code:
  ```bash
   bin/cashier
   ```
   or if `bin/cashier` is not executable:
   ```bash
   ruby lib/main.rb
   ```

## Structure

- `lib/` - Application code
- `test/` - Test files
- `bin/` - Executable files
- `Rakefile` - Build tasks

# Assignment

You are the lead programmer for a small chain of supermarkets. You are required to make a simple cashier function that adds products to a cart and displays the total price.

## Products

| Product Code | Name         | Price |
|--------------|--------------|-------|
| GR1          | Green tea    | £3.11 |
| SR1          | Strawberries | £5.00 |
| CF1          | Coffee       | £11.23 |

## Special Conditions

- **CEO (Green Tea BOGO)**: The CEO is a big fan of buy-one-get-one-free offers and of green tea. He wants us to add a rule to do this.
- **COO (Strawberry Bulk Discount)**: The COO likes low prices and wants people buying strawberries to get a price discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to £4.50
- **CTO (Coffee Bulk Discount)**: The CTO is a coffee addict. If you buy 3 or more coffees, the price of all coffees should drop to two thirds of the original price.

## Requirements

Our check-out can scan items in any order, and because the CEO and COO change their minds often, it needs to be flexible regarding our pricing rules.

**Interface:**
```ruby
co = Checkout.new(pricing_rules)
co.scan(item)
co.scan(item)
price = co.total
```

## Test Data

| Basket | Expected Total |
|--------|----------------|
| GR1,SR1,GR1,GR1,CF1 | £22.45 |
| GR1,GR1 | £3.11 |
| SR1,SR1,GR1,SR1 | £16.61 |
| GR1,CF1,SR1,CF1,CF1 | £30.57 |
