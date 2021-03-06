require_relative 'find_by'
require_relative 'errors'
require 'csv'
require 'pathname'

class Udacidata
  create_finder_methods :brand, :name

  CSV_FILE = Pathname(File.dirname(__FILE__) + '/../data/data.csv')

  # Always creates a new product object and returns it. If that object does not
  # already exist in the CSV file, it is also saved to the CSV file. Please note
  # that I check if the products ID exists to verify if the item is already in
  # the CSV file. Additionally, I avoided using my existing `find` method to
  # prevent an error from being raised when the ID doesn't exist.
  def self.create(options = {})
    product = new(options)
    unless all.any? { |item| item.id == product.id }
      CSV.open(CSV_FILE, 'ab') do |csv|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
    product
  end

  def self.all
    products = []
    CSV.foreach(CSV_FILE, headers: true) do |row|
      products << new(id: row['id'], brand: row['brand'], name: row['product'],
                      price: row['price'])
    end
    products
  end

  def self.first(*n)
    n[0] ? all.first(n[0]) : all.first
  end

  def self.last(*n)
    n[0] ? all.last(n[0]) : all.last
  end

  def self.find(id)
    result = all.find { |product| product.id == id }
    unless result
      raise UdacidataErrors::ProductNotFoundError,
            "Could not find a product with an ID of #{id}"
    end
    result
  end

  def self.destroy(id)
    destroyed_product = find(id)

    updated_products = all.delete_if { |product| product.id == id }
    rewrite_csv(updated_products)

    destroyed_product
  end

  def self.rewrite_csv(products)
    CSV.open(CSV_FILE, 'wb') do |csv|
      csv << %w(id brand product price)
      products.each do |product|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
  end

  # The description of this method in the lesson:
  #   "Product.where should return an array of Product objects that match a
  #   given brand or product name."
  # It seems to require only one or the other of the options to work. That felt
  # a bit wrong, so I made the where method work with brand and name at the same
  # time. I chose to find all products where the brand OR the name matched, not
  # all products where both the brand AND the name matched.
  def self.where(options = {})
    brand_products = []
    if options[:brand]
      brand_products = all.select { |product| product.brand == options[:brand] }
    end

    name_products = []
    if options[:name]
      name_products = all.select { |product| product.name == options[:name] }
    end

    brand_products.concat(name_products)
  end

  def update(options = {})
    Product.destroy(@id)
    @brand = options[:brand] if options[:brand]
    @name = options[:name] if options[:name]
    @price = options[:price] if options[:price]
    Product.create(id: @id, brand: @brand, name: @name, price: @price)
  end
end
