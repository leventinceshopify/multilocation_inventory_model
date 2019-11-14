require './location.rb'
class StoreFront < Location
  #write duck_typing instance_methods
  def to_s
    "Store Front==>" << super.to_s    #{@name} Address: #{@address}"
  end

  def ship_item
    puts
    "We are a local store. We will ship to your address"
  end
end
