require 'white_promo'

describe "White Promo" do

  context "Initializing a white promotion order with any invalid hash" do
    it 'returns This order is invalid' do
      expect{WhitePromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"2", :type=>"white"})}.to raise_error("This order is invalid")
      expect{WhitePromo.new({:cash=>"12", :price=>"0", :wrappersneeded=>"4", :type=>"white"})}.to raise_error("This order is invalid")
      expect{WhitePromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"10", :type=>"caramel"})}.to raise_error("This order is invalid")
    end
  end

  context "Calling calculate on a valid initialized white promotion order hash with 0 wrappers needed" do
    it "returns an array with only number of white chocolates purchased" do
      white_promo = WhitePromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"0", :type=>"white"})
      redemptions = white_promo.redemptions
      array = ["milk 0", " dark 0", " white #{white_promo.chocolates_purchased}", " sugar free 0"]
      expect(array).to eq(white_promo.calculate)
    end
  end

  context "Calling calculate on a valid initialized white promotion order hash with cash 12, price 3 and wrappersneeded 3" do
    it "calculates the white promotion and returns an array containing additional white and sugarfree chocolates.
        It does not calculate the sugarfree promotion if white promotion generates less than 3 sugarfree chocolates." do
      results = ["milk 0", " dark 0", " white 5", " sugar free 1"]
      white_promo = WhitePromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"3", :type=>"white"}).calculate
      expect(results).to eq(white_promo)
    end
  end

  context "Calling calculate on a valid initialized white promotion order hash with cash 32, price 4 and wrappersneeded 3" do
    it "calculates the white and sugarfree promotion and returns an array containing white, sugarfree, and dark chocolates.
        It does not calculate the dark promotion if sugarfree promotion generates less than 3 dark chocolates." do
      results = ["milk 0", " dark 1", " white 11", " sugar free 4"]
      white_promo = WhitePromo.new({:cash=>"32", :price=>"4", :wrappersneeded=>"3", :type=>"white"}).calculate
      expect(results).to eq(white_promo)
    end
  end

  context "Calling calculate on a valid initialized white promotion order hash with cash 12, price 3 and wrappersneeded 2" do
    it "calculates the white, sugarfree and dark promotions if there are more than 2 chocolates of each type.
        Returns an array containing white, sugarfree, and dark chocolates." do
      results = ["milk 0", " dark 3", " white 7", " sugar free 5"]
      white_promo = WhitePromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"2", :type=>"white"}).calculate
      expect(results).to eq(white_promo)
    end
  end

end
