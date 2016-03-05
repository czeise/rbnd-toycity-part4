require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  CSV_FILE = File.dirname(__FILE__) + '/../data/data.csv'

  # TODO: Update method to check for existing id. See @david's comment in
  # #toycity4
  def self.create(options = {})
    product = Product.new(options)
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

  def self.first
    first_row = CSV.open(CSV_FILE, 'rb', headers: true, &:first)
    new(id: first_row['id'], brand: first_row['brand'],
        name: first_row['product'], price: first_row['price'])
  end
end
