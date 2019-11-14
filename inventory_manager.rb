require './item.rb'
# require './product.rb'
require './address.rb'
require './dropshipper.rb'
require './warehouse.rb'
require './inventory.rb'
require './item_line.rb'
require './state.rb'
# require './location.rb'


class InventoryManager

attr_accessor :item_packet, :locations
  def initialize
    @item_packet = []  #keeps item objects and associated numbers
    @locations = {}  #keeps location objects in hash form, key is the location name, value is the location object itself
  end

  def define_new_item_serie(file, delimiter)
    # file = File.open("items.text")
    File.foreach(file) do |line|
      arr = line.split(delimiter)
      item_line = ItemLine.new(Item.new(arr[0],"" , arr[1],arr[2]),arr[3].to_i)  #name, description = "", manifacturer=nil, cost=0, size="", type = "")
       @item_packet.push(item_line)
     end

  end

  def empty_item_serie
    @item_packet = []
  end

  def define_products

  end

  def define_location(location)
    @locations[location.name] = location
  end

  def sell_product(location_name, item_name, inventory)
      inventory.sell_item(location_name, item_name)
  end

end

im = InventoryManager.new

#creates company's inventory
company_inventory = Inventory.new

# define locations with an address


puts
puts "@@@@@@@@@@@@@@@@@@@@ SHOW EMPTY INVENTORY AT THE BEGINNIG@@@@@@@@@@@@@@@@@@@@@@@@"
puts

company_inventory.print_inventory

a = gets.chomp


im.define_location(DropShipper.new("DropShipperOttawa", Address.new(436, "Harvest Ave", "K4A OV6", "Ottawa", "ON", "Canada")))
im.define_location(Warehouse.new("Orleans Warehousing", Address.new(123, "Esprit Street", "K1J 2V3", "Ottawa", "ON", "Canada")))

# read item information from file to load them to a location
im.define_new_item_serie("./itemsTV.text", ";")


puts
puts "@@@@@@@@@@@@@@@@@@@@ LOAD SOME ITEMS @@@@@@@@@@@@@@@@@@@@@@@@"
puts


#replenish the global inventory by loading items to a location
#replenish(item_packet, location, state)
company_inventory.replenish(im.item_packet, im.locations["DropShipperOttawa"], State.new("Available"))
# after laod the packet to corresponding location, empty the packet
im.empty_item_serie

puts
puts "@@@@@@@@@@@@@@@@@@@@ SHOW CURRENT INVENTORY @@@@@@@@@@@@@@@@@@@@@@@@"
puts

a = gets.chomp
company_inventory.print_inventory
a = gets.chomp
puts
puts "@@@@@@@@@@@@@@@@@@@@     SELL ONE ITEM      @@@@@@@@@@@@@@@@@@@@@@@@"
puts
a = gets.chomp
sold_product = "LG_20_TV"
sold_product_location =  "DropShipperOttawa"
im.sell_product(sold_product_location,  sold_product, company_inventory)

puts
puts "@@@@@@ SHOW CURRENT INVENTORY AFTER SELLING AN ITEM @@@@@@@@@@@@@@@@"
puts
a = gets.chomp
company_inventory.print_inventory
a = gets.chomp

puts
puts "@@@@@@@@@@@@@@@@@@@@ REPLENISH ANOTHER LOCATION @@@@@@@@@@@@@@@@@@@@@@@@"
puts
# replenish another location with a new item set
im.define_new_item_serie("./itemsTV.text", ";")
company_inventory.replenish(im.item_packet, im.locations["Orleans Warehousing"], State.new("Available"))
a = gets.chomp
puts
puts "@@@@@@@@@@@@@@@@@@@@ SHOW NEW INVENTORY @@@@@@@@@@@@@@@@@@@@@@@@"
puts
a = gets.chomp
company_inventory.print_inventory

# replenish one of the location with a new item set
im.define_new_item_serie("./itemsWashers.text", ";")
company_inventory.replenish(im.item_packet, im.locations["Orleans Warehousing"], State.new("Available"))
a = gets.chomp
puts
puts "@@@@@@@@@@@@@@@@@@@@ SHOW NEW INVENTORY AFTER FURTHER REPLENISHMENT@@@@@@"
puts
a = gets.chomp
company_inventory.print_inventory



#----------------------------------
# Randomly sell items from random locations


item_packet_length = im.item_packet.length

#Randomly sell items
a = gets.chomp
puts
puts "@@@@@@@@@@@@@@@@@@@@     START RANDOM SALES     @@@@@@@@@@@@@@@@@@@@@@@@"
puts
a = gets.chomp

for i in (1..9200)

  sold_product = im.item_packet[rand(item_packet_length)].item.name  #item_line = ItemLine.new(Item.new(arr[0],"" , arr[1],arr[2]),arr[3].to_i)
  sold_product_location = rand(2)==0 ?  "DropShipperOttawa" : "Orleans Warehousing"
  im.sell_product(sold_product_location,  sold_product, company_inventory)

end

puts
puts "@@@@@@@@@@@@@@@ AFTER RANDOM SALES, REMAINING INVENTORY @@@@@@"
puts
company_inventory.print_inventory
