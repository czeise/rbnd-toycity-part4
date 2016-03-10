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

  # TODO: Finish this up and put it all in a single string instead of using puts
  def print_report(products)
    puts "Average Price: #{average_price(products)}"
    puts 'Inventory by Brand:'
    count_by_brand(products).each do |brand, inventory|
      puts "  - #{brand}: #{inventory}"
    end
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
