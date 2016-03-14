module Analyzable
  # Your code goes here!
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

  # TODO: Consider metaprogramming the count_by_methods
  def count_by_brand(products)
    brand_inventory = {}
    products.each do |product|
      if brand_inventory.key?(product.brand)
        brand_inventory[product.brand] += 1
      else
        brand_inventory[product.brand] = 1
      end
    end
    brand_inventory
  end

  def count_by_name(products)
    product_inventory = {}
    products.each do |product|
      if product_inventory.key?(product.name)
        product_inventory[product.name] += 1
      else
        product_inventory[product.name] = 1
      end
    end
    product_inventory
  end
end
