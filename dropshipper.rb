require './location.rb'

class DropShipper < Location
  #write duck_typing instance_methods
  def to_s
    "Dropshipper==>" << super.to_s
  end

  def ship_item
    puts
    "We are a dropshipper company. We will ship the item for you"

  end
end
