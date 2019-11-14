class Location
  @@location_id = 0
  attr_accessor :location_id, :name,  :address      #get the address from the type   . types are dropshipper, local_warehouse, retail_storefront, warehause, fullfilment_service

  def initialize(name, address = nil)
    @location_id = @@location_id += 1
    @name = name
    @address = address
  end

  def ship_package
    puts "General shipment"
  end

  def to_s
    "Id: #{@location_id} #{@name} Address: #{@address}"
  end
end
