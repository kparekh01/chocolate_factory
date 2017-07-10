require 'dark_promo'

describe "DarkPromo" do

  context "Initializing a dark promotion order with any invalid hash" do
    it 'returns This order is invalid' do
      expect{DarkPromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"2", :type=>"dark"})}.to raise_error("This order is invalid")
      expect{DarkPromo.new({:cash=>"12", :price=>"0", :wrappersneeded=>"4", :type=>"dark"})}.to raise_error("This order is invalid")
      expect{DarkPromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"10", :type=>"caramel"})}.to raise_error("This order is invalid")
    end
  end

  context "Calling calculate on a valid initialized dark promotion order hash with 0 wrappers needed" do
    it "returns an array with only number of dark chocolates purchased" do
      dark_promo = DarkPromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"0", :type=>"dark"})
      redemptions = dark_promo.redemptions
      array = ["milk 0", " dark #{dark_promo.chocolates_purchased}", " white 0", " sugar free 0"]
      expect(array).to eq(dark_promo.calculate)
    end
  end

  context "Calling calculate on a valid initialized dark promotion order hash with cash 12, price 3 and wrappersneeded 5" do
    it "does not calculate the dark promotion if order generates less than 5 dark chocolates.
        returns an array with only number of dark chocolates purchased"do
      dark_promo = DarkPromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"5", :type=>"dark"})
      results = ["milk 0", " dark 4", " white 0", " sugar free 0"]
      expect(results).to eq(dark_promo.calculate)
    end
  end

  context "Calling calculate on a valid initialized dark promotion order hash with cash 12, price 3 and wrappersneeded 2" do
    it "calculates the dark promotion if order generates more than 2 dark chocolates.
        returns an array with additional dark chocolates added"do
      dark_promo = DarkPromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"2", :type=>"dark"})
      results = ["milk 0", " dark 7", " white 0", " sugar free 0"]
      expect(results).to eq(dark_promo.calculate)
    end
  end

end
