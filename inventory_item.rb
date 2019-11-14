
#  This is what is kept in Inventory as a multi location item
# The key is the aggregation of item, location and state
class InventoryItem

  @@unique_inventory_item_id = 0
  # @@total_selled = 0
  # @@total_available = 0

  attr_accessor :item, :location, :state, :quantity, :is_sellable, :warning_threshold
  def initialize(item, location , state, quantity, is_sellable = true, warning_threshold= 10)
    @inventory_item_id = @@unique_inventory_item_id += 1
    @item = item
    @location = location
    @state = State.new("Available")
    @quantity = quantity
    @is_sellable = is_sellable
    @warning_threshold = warning_threshold

  end
  def to_s
    "item: #{@item.name}, Location : #{@location.name}, State: #{@state} Quantity: #{@quantity} "
  end

  # called by customer or merchant
  def add_quantity(number)
    @quantity += number
  end

  def remove_quantity(number)
    @quantity -= number
  end

  def ship_item(location , item )
    @location.ship_item
  end

  def sell_item(location , item, count )
    if @quantity > 0
      #first ship the item
      puts ship_item(location , item )
      #after remove the item from inventory
      remove_quantity(count)
    end
  end

  def change_state(type )
    @state.type = type
  end


end
