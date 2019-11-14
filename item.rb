#this is what kept in the inventory
class Item

  @@unique_SKU = 0
  @@total_selled = 0
  @@total_available = 0

  attr_accessor :item_id, :name, :description, :manifacturer, :cost, :size, :type
  def initialize(name, description = "", manifacturer=nil, cost=0, size="", type = "")
    @SKU = @@unique_SKU += 1
    @name = name
    @description = description
    @manifacturer =manifacturer
    @cost = cost
    @size = size
    @type = type #hardware, software, etc.
  end
  def to_s
    "Name: #{@name}, Description : #{@description}, Manufacturer: #{@manifacturer} Procurement Cost: #{@cost} "
  end
end
