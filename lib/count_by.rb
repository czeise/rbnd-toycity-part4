class Module
  def create_count_by_methods(*attributes)
    attributes.each do |attribute|
      count_by_methods = %{
        def count_by_#{attribute}(products)
          product_inventory = {}
          products.each do |product|
            if product_inventory.key?(product.#{attribute})
              product_inventory[product.#{attribute}] += 1
            else
              product_inventory[product.#{attribute}] = 1
            end
          end
          product_inventory
        end
      }
      class_eval(count_by_methods)
    end
  end
end
