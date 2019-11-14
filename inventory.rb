# Only one instance,  Keeps all the inventory as a list of inventory_item

require './inventory_item.rb'
class Inventory

  attr_accessor  :inventory
  def initialize
    @inventory = Hash.new{0}
  end

  def print_inventory
    puts "Location \t Item Name \t\t Manifacturer \t\t Cost \t Number Available \t "
    puts "________\t_______________\t\t______________\t\t______\t_________________"
    @inventory.each do |key, value|
      print "#{ value.location.name.ljust(20) }   #{ value.item.name.ljust(20) }   #{value.item.manifacturer.ljust(20)}   #{value.item.cost.to_s.ljust(10)}   #{value.quantity.to_s.rjust(10)}  "
      puts
    end

  end

  def replenish(item_packet, location, state)
    item_packet.each do |item_line|
      #the key for inventory hash is the combination of item, location and state
      inventory_key = [item_line.item.name, location.name, state.status]
      #  quantity of item in inventory before replenish
      current_quantity = 0
      # If there is already such an inventory_item in the hash
      current_quantity = @inventory[inventory_key].quantity if @inventory[inventory_key].class.to_s == "InventoryItem"
      #create an inventory item
      inventory_item = InventoryItem.new(item_line.item, location, state, item_line.quantity + current_quantity)  # item, location , state, quantity, is_sellable = true, warning_threshold= 10)
      #hit the inventory item to the hash
      @inventory[inventory_key] = inventory_item

      # puts "replenish &&&&&&&&&&&&"
      # puts inventory_key
      # puts @inventory[inventory_key]
      # puts "&&&&&&&&&&&&"

      # puts "&&&&&&&&&&&&"
      # puts @inventory[inventory_key].quantity
      # puts "&&&&&&&&&&&&"
    end
  end

  def remove_from_inventory(inventory_key )
    out_of_stock = false
    # if @inventory[inventory_key][2] > 0
      @inventory[inventory_key].quantity -= 1
      # puts "One #{item} is sold."

      if @inventory[inventory_key].quantity == 0
        @inventory[inventory_key].state = State.new("Out of stock")
        out_of_stock = true
        puts "In Location #{@inventory[inventory_key].location.name} inventory for the #{@inventory[inventory_key].item.name} becomes empty"

      end
    # end
  end

  def ship_item(location , item )
    location.ship_item
  end

  def sell_item(location_name , item_name )

    state = State.new("Available")  #Change this line later
    inventory_key = [item_name, location_name, state.status]

    # puts "sell item&&&&&&&&&&&&"
    # puts inventory_key
    # puts "&&&&&&&&&&&&"
    # puts @inventory[inventory_key].class
    # puts @inventory[inventory_key]

    if @inventory[inventory_key].class.to_s == "InventoryItem" && @inventory[inventory_key].quantity > 0
      #first ship the item
      # puts ship_item(@inventory[inventory_key].location , @inventory[inventory_key].item )
      #after remove the item from inventory
      remove_from_inventory(inventory_key )
    end

  end

end
