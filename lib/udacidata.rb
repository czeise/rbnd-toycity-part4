require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  create_finder_methods :brand, :name

  # TODO, apparently there's a better way to do this...see Walter's comment in 
  # slack.
  CSV_FILE = File.dirname(__FILE__) + '/../data/data.csv'

  # TODO: Update method to check for existing id. See @david's comment in
  # #toycity4, if I'd like...I can go more in depth on this to make sure it's
  # the same product!
  def self.create(options = {})
    product = new(options)
    CSV.open(CSV_FILE, 'ab') do |csv|
      csv << [product.id, product.brand, product.name, product.price]
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
    all.find do |product|
      product.id == id
    end
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
end
