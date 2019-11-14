require './location.rb'
class Warehouse < Location
  #write duck_typing instance_methods
  def to_s
    "Warehouse==>" << super.to_s    #{@name} Address: #{@address}"
  end

  def ship_item
    puts
    "We are a warehouse. Sorry we cannot make shipment. You come and get it!!!!"
  end
end
