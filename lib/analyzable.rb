require_relative 'count_by'

module Analyzable
  # Your code goes here!

  # Create count_by methods using metaprogramming
  create_count_by_methods :brand, :name

  def average_price(products)
    total_price = 0
    num_products = 0
    products.each do |product|
      total_price += product.price.to_f
      num_products += 1
    end
    (total_price / num_products).round(2)
  end

  def print_report(products)
    report = "Average Price: #{average_price(products)}\n"
    report += "Inventory by Brand:\n"
    count_by_brand(products).each do |brand, inventory|
      report += "  - #{brand}: #{inventory}\n"
    end
    report += "Inventory by Product:\n"
    count_by_name(products).each do |product, inventory|
      report += "  - #{product}: #{inventory}\n"
    end
    report
  end
end
