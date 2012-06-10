class Product

  attr_reader :attributes_hash

  def self.find query, params = {}
    products_hash = Search.find query, params
    if products_hash['items']
      products_hash['items'].map { |product_hash| Product.new(product_hash['product']) }
    else
      []
    end
  end


  def initialize attr_hash
    @attributes_hash = attr_hash
  end

  def title
    attributes_hash['title']
  end

  def description
    attributes_hash['description']
  end

  def image
    images_array = attributes_hash['images']
    images_array.first['link']
  end

  def price
    inventory['price']
  end

  def currency
    inventory['currency']
  end

  private

  def inventory
    inventories_array = attributes_hash["inventories"]
    inventories_array.first
  end

end
