class Inventory

  attr_accessor  :inventory
  def initialize
    @inventory = Hash.new{0}
  end

  def print_inventory
    puts "Location \t Item Name \t\t Manifacturer \t\t Cost \t Number Available \t "
    puts "________\t_______________\t\t______________\t\t______\t_________________"
    @inventory.each do |key, value|
      print "#{ key[0].ljust(20) }   #{ key[1].ljust(20) }   #{value[1].manifacturer.ljust(20)}   #{value[1].cost.ljust(10)}   #{value[2].to_s.rjust(10)}  "
      puts
    end

  end

  def replenish(location, item_packet)

    item_packet.each do |item|
      #inventory is a hash.  Key is the combination of location and item object in an array, value is the numnber of item
      #location is a location  object , item is a item object.
      #item[0] = item itself,   item[1] = the number of item
      # @inventory[[location, item[0]]] += item[1].to_i
      current_number_of_item = @inventory[[location.name, item[0].name]][2]


      # puts "Current number is #{current_number_of_item}"
      @inventory[[location.name, item[0].name]]  = [location, item[0], current_number_of_item += item[1].to_i]
    end
  end

  def remove_from_inventory(location , item )
    out_of_stock = false
    if @inventory[[location , item]][2] > 0
      @inventory[[location , item]][2] -= 1
      # puts "One #{item} is sold."

      if @inventory[[location , item]][2] == 0
        out_of_stock = true
        puts "In Location #{location} inventory for the #{item} becomes empty"

      end
    end
  end

  def ship_item(location , item )
    @inventory[[location , item]][0].ship_item
  end

  def sell_item(location , item )

    if @inventory[[location , item]][2] > 0
      #first ship the item
      # puts ship_item(location , item )
      #after remove the item from inventory
      remove_from_inventory(location , item )
    end

  end

end
