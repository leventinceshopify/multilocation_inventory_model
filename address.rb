class Address
  attr_accessor :street_number, :street_name, :postal_code, :city, :province, :country

  def initialize (street_number, street_name,  postal_code, city, province, country)

      @street_number = street_number
      @street_name = street_name
      @postal_code = postal_code
      @city = city
      @province = province
      @country = country
  end

  def to_s
    "#{@street_number} #{@street_name}, #{@postal_code}, #{@city}, #{@province} , #{@country}"
  end
end
