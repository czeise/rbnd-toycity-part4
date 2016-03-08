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
end
