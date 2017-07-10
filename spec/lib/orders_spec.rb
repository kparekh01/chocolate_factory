require 'orders'


describe "Order" do

  context "Initializing an order with an invalid array" do
    it 'raises an argument error with "This class is only initialized with an array of arrays"' do
      invalid_array_1 = [["cash", " price", " wrappers needed", " type"], {"ImNot" => "Supposedtobehere"}, ["12", " 2", " 5", " 'milk'"], ["6", " 2", " 2", " 'sugar free'"]]
      invalid_array_2 = [[], ["cash", " price", " wrappers needed", " type"], "Hello!", ["12", " 2", " 5", " 'milk'"], ["6", " 2", " 2", " 'sugar free'"]]
      expect{Orders.new(invalid_array_1)}.to raise_error("This class is only initialized with an array of arrays")
      expect{Orders.new(invalid_array_2)}.to raise_error("This class is only initialized with an array of arrays")
    end
  end

  context "Initializing an order with a valid array" do
    it 'assigns the instance variable @input_csv_file to the array' do
      valid_array_1 = [["cash", " price", " wrappers needed", " type"], ["12", " 2", " 5", " 'milk'"], ["6", " 2", " 2", " 'sugar free'"]]
      valid_array_2 = [[], ["cash", " price", " wrappers needed", " type"], ["12", " 2", " 5", " 'milk'"], ["6", " 2", " 2", " 'sugar free'"]]
      expect(Orders.new(valid_array_1).input_csv_file).to eq(valid_array_1)
      expect(Orders.new(valid_array_2).input_csv_file).to eq(valid_array_2)
    end
  end

  context "Calling generate_order_array on a valid array, that does not have exactly 4 headers" do
    it 'raises "This array of orders does not contain exactly 4 headers" error' do
      test_array_1 = Orders.new([["cash", " price", " wrappers needed"], ["12", " 2", " 5", " 'milk'"], ["6", " 2", " 2", " 'sugar free'"]])
      test_array_2 = Orders.new([["one", " two"], ["12", " 2", " 5", " 'milk'"], ["6", " 2", " 2", " 'sugar free'"]])
      expect{test_array_1.generate_order_array}.to raise_error("This array of orders does not contain exactly 4 headers")
      expect{test_array_2.generate_order_array}.to raise_error("This array of orders does not contain exactly 4 headers")
    end
  end

  context "Calling generate_order_array on a valid array, that contains exactly 4 headers" do
    it 'outputs an array of hashes excluding the headers and arrays that did not have exactly 4 elements' do

      valid_array_1 = [#(3 not included in output)
        ["cash", " price", " wrappers needed", " type"], #will not output
        [], #ignored
        ["12", " 2", " 5", " 'milk'"],
        ["12", " 4", " 4", " 'dark'"],
        [" 2", " 2", " 'sugar free'"], #ignored
        ["6", " 2", " 2", " 'white'"]
      ]

      valid_array_2 = [ #(4 not included in output)
        ["cash", " price", " wrappers needed", " type"], #will not output
        ["12", " 2", " 5", " 'milk'"],
        ["12", " 2", " 'milk'"],#ignored
        ["12", " 4", " 4", " 'dark'"],
        [" 2", " 2", " 'sugar free'"],#ignored
        ["6", " 2", " 2"]#ignored
      ]

      result_1 = [
        {:cash=>"12", :price=>"2", :wrappersneeded=>"5", :type=>"milk"},
        {:cash=>"12", :price=>"4", :wrappersneeded=>"4", :type=>"dark"},
        {:cash=>"6", :price=>"2", :wrappersneeded=>"2", :type=>"white"}
      ]

      result_2 = [
        {:cash=>"12", :price=>"2", :wrappersneeded=>"5", :type=>"milk"},
        {:cash=>"12", :price=>"4", :wrappersneeded=>"4", :type=>"dark"}
      ]

      order_array_1 = Orders.new(valid_array_1).generate_order_array
      order_array_2 = Orders.new(valid_array_2).generate_order_array

      expect(result_1).to eq(order_array_1)
      expect(result_2).to eq(order_array_2)
      expect(valid_array_1.count - 3).to eq(order_array_1.count)
      expect(valid_array_1.count - 4).to eq(order_array_2.count)
    end
  end

end
