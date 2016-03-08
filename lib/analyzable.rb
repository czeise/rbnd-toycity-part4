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

  # TODO: This is totally cheating!
  def print_report(products)
    ""
  end

  # TODO: Figure out how to get the actual count for each brand
  # START HERE!
  def count_by_brand(products)
    brand_inventory = {}
    products.each do |product|
      brand_inventory[product.brand] = 1
    end
    brand_inventory
  end
end
