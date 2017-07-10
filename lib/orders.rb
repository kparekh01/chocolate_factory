
class Orders
  attr_accessor :input_csv_file
  def initialize(input_csv_file)
    if input_csv_file.all?{|element| element.class == Array}
      @input_csv_file = input_csv_file
    else
      raise ArgumentError.new("This class is only initialized with an array of arrays")
    end
  end
  def generate_order_array
    filtered_elements = []
    if @input_csv_file[0].length == 4
      @input_csv_file.each do |array|
        if array.length == 4
          array.each do |element|
            filtered_elements << element.split("").delete_if{|char| char == " " || char == "'"}.join
          end
        end
      end
      orders = []
      filtered_elements[4..-1].each_slice(4) do |arr|
        chocolate_hash = {}
        chocolate_hash[filtered_elements[0].to_sym] = arr[0]
        chocolate_hash[filtered_elements[1].to_sym] = arr[1]
        chocolate_hash[filtered_elements[2].to_sym] = arr[2]
        chocolate_hash[filtered_elements[3].to_sym] = arr[3]
        orders << chocolate_hash
      end
      return orders
    else
      raise ArgumentError.new("This array of orders does not contain exactly 4 headers")
    end
  end
end
