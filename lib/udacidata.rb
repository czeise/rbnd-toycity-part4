require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
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
    updated_products = all.delete_if { |product| product.id == id }
    rewrite_csv(updated_products)
  end

  def self.rewrite_csv(products)
    CSV.open(CSV_FILE, 'wb') do |csv|
      csv << %w(id brand product price)
      products.each do |product|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
  end
end
