
# This is what is sold to the customers.  It consists of one or more item_list
class Variant

  @@unique_variant_id = 0
  # @@total_selled = 0
  # @@total_available = 0

  attr_accessor :name, :item_list, :description, :price, :cost, :picture_url, :size
  def initialize(name, description = "", picture_url, price = 0, cost=0, picture_url, size="", type = "")
    @variant_id = @@unique_variant_id += 1
    @name = name
    @item_list = Hash.new
    @description = description
    @manifacturer =manifacturer
    @price = 0
    @cost = 0
    @picture_url = picture_url
    @size = size
    @type = type
  end
  def to_s
    "Name: #{@name}, Description : #{@description}, Manufacturer: #{@manifacturer} Procurement Cost: #{@cost} "
  end

  # called by customer or merchant
  def add_item(item)
    @item_list[item] += 1
    calculate_cost
  end

  def calculate_cost
    @cost = 0
    @item_list.each do |i, c|
      @cost = @cost + item_list[i].cost * c
    end
  end

  def calculate_price
    @price = 0
    @item_list.each do |i, p|
      @price = @price + tem_list[i].price * c
    end
  end

  # Ask Dom how to do it
  #   Customer forms a Variant by aggregation different items???

  def self.form_variant(item)

  end



end
