# Only one instance,  Keeps all the inventory as a list of inventory_item

require './inventory_item.rb'
class Inventory

  attr_accessor  :inventory, :inventory_locations
  def initialize
    @inventory = Hash.new{0}
    @inventory_locations = Hash.new(0)
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

    end
  end


  def add_item(item, location, state, quantity)

      #the key for inventory hash is the combination of item, location and state
      inventory_key = [item.name, location.name, state.status]
      #  quantity of item in inventory before replenish
      current_quantity = 0
      # If there is already such an inventory_item in the hash
      current_quantity = @inventory[inventory_key].quantity if @inventory[inventory_key].class.to_s == "InventoryItem"
      #create an inventory item
      inventory_item = InventoryItem.new(item, location.name, state.status, quantity + current_quantity)  # item, location , state, quantity, is_sellable = true, warning_threshold= 10)
      #hit the inventory item to the hash
      @inventory[inventory_key] = inventory_item

  end

  def remove_item(item, location, state, quantity)

      #the key for inventory hash is the combination of item, location and state

puts "IN REMOVE ITEM #{item.class} "
puts "IN REMOVE ITEM #{item.name} "
      inventory_key = [item.name, location.name, state.status]
      #  quantity of item in inventory before replenish
      current_quantity = 0
      # If there is already such an inventory_item in the hash
      current_quantity = @inventory[inventory_key].quantity if @inventory[inventory_key].class.to_s == "InventoryItem"
      #create an inventory item
      inventory_item = InventoryItem.new(item, location.name, state.status,  current_quantity - quantity)  # item, location , state, quantity, is_sellable = true, warning_threshold= 10)
      #hit the inventory item to the hash
      @inventory[inventory_key] = inventory_item

  end

  def remove_from_inventory(inventory_key )
    out_of_stock = false
    # if @inventory[inventory_key][2] > 0
      @inventory[inventory_key].quantity -= 1

      if @inventory[inventory_key].quantity <= @inventory[inventory_key].warning_threshold
        @inventory[inventory_key].state = State.new("Low stock")
        puts
        puts "Warning_threshold: In Location #{@inventory[inventory_key].location.name}"
        puts "Inventory for the #{@inventory[inventory_key].item.name} IS #{@inventory[inventory_key].quantity}  IT IS LOW!!!!!"
        puts

         check_availability_of_item_in_other_locations(inventory_key)

      end




      if @inventory[inventory_key].quantity == 0
        @inventory[inventory_key].state = State.new("Out of stock")
        out_of_stock = true
      puts "   ATTENTION In Location #{@inventory[inventory_key].location.name} inventory for the #{@inventory[inventory_key].item.name} becomes empty"

      end
    # end
  end

  def ship_item(location , item )
    location.ship_item
  end

  def sell_item(location_name , item_name )

    state = State.new("Available")  #Change this line later
    inventory_key = [item_name, location_name, state.status]

    if @inventory[inventory_key].class.to_s == "InventoryItem" && @inventory[inventory_key].quantity > 0
      remove_from_inventory(inventory_key )
    end

  end


  def check_availability_of_item_in_other_locations(inventory_key)
       @inventory_locations.each do |loc|
      #   puts "LOCATION IN LOOP #{loc[0]}"
        search_inventory_key = [inventory_key[0], loc[0], inventory_key[2]]
          if @inventory[search_inventory_key].class.to_s == "InventoryItem" && @inventory[inventory_key].quantity != 0 && (@inventory[search_inventory_key].quantity >= 2 * @inventory[inventory_key].quantity)
            puts "[#{inventory_key[0]} is available in #{loc[0]}"
            puts "source inventory = #{@inventory[inventory_key].quantity}"
            puts "target inventory = #{@inventory[search_inventory_key].quantity}"
            puts

            # transfer_item(inventory_key[0], loc[0], @inventory[inventory_key].item, 10)
            break

          end


       end
  end


  def transfer_item(source_location, target_location, item, quantity)
     remove_item(item, source_location, State.new("Available"), quantity)
     add_item(item, target_location, State.new("Available"), quantity)

  end

end
