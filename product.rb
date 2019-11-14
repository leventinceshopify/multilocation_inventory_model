class Product

  @@unique_product_id = 0
  # @@total_selled = 0
  # @@total_available = 0

  attr_accessor :name, :variant_list, :description, :manifacturer, :picture_url
  def initialize(name, description = "", manifacturer=nil, picture_url)
    @product_id = @@unique_product_id += 1
    @name = name
    @variant_list = Hash.new
    @description = description
    @manifacturer =manifacturer
    @picture_url = picture_url

  end
  def to_s
    "Name: #{@name}, Description : #{@description}, Manufacturer: #{@manifacturer}  "
  end

  # called by customer or merchant
  def add_variant(variant)
    @variant_list[variant] += 1

  end



end
