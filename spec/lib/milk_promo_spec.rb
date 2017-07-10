require 'milk_promo'

describe "Milk Promo" do

  context "Initializing a milk promotion order with any invalid hash" do
    it 'returns This order is invalid' do
      expect{MilkPromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"2", :type=>"milk"})}.to raise_error("This order is invalid")
      expect{MilkPromo.new({:cash=>"12", :price=>"0", :wrappersneeded=>"4", :type=>"milk"})}.to raise_error("This order is invalid")
      expect{MilkPromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"10", :type=>"caramel"})}.to raise_error("This order is invalid")
    end
  end

  context "Calling calculate on a valid initialized milk promotion order hash with 0 wrappers needed" do
    it "returns an array with only number of milk chocolates purchased" do
      milk_promo = MilkPromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"0", :type=>"milk"})
      redemptions = milk_promo.redemptions
      array = ["milk #{milk_promo.chocolates_purchased}", " dark 0", " white 0", " sugar free 0"]
      expect(array).to eq(milk_promo.calculate)
    end
  end

  context "Calling calculate on a valid initialized milk promotion order hash with cash 12, price 3 and wrappersneeded 3" do
    it "calculates the milk promotion and returns an array containing additional milk and sugarfree chocolates.
        It does not calculate the sugarfree promotion if milk promotion generates less than 3 sugarfree chocolates." do
      results = ["milk 5", " dark 0", " white 0", " sugar free 1"]
      milk_promo = MilkPromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"3", :type=>"milk"}).calculate
      expect(results).to eq(milk_promo)
    end
  end

  context "Calling calculate on a valid initialized milk promotion order hash with cash 32, price 4 and wrappersneeded 3" do
    it "calculates the milk and sugarfree promotion and returns an array containing milk, sugarfree, and dark chocolates.
        It does not calculate the dark promotion if sugarfree promotion generates less than 3 dark chocolates." do
      results = ["milk 11", " dark 1", " white 0", " sugar free 4"]
      milk_promo = MilkPromo.new({:cash=>"32", :price=>"4", :wrappersneeded=>"3", :type=>"milk"}).calculate
      expect(results).to eq(milk_promo)
    end
  end

  context "Calling calculate on a valid initialized milk promotion order hash with cash 12, price 3 and wrappersneeded 2" do
    it "calculates the milk, sugarfree and dark promotions if there are more than 2 chocolates of each type.
        Returns an array containing milk, sugarfree, and dark chocolates." do
      results = ["milk 7", " dark 3", " white 0", " sugar free 5"]
      milk_promo = MilkPromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"2", :type=>"milk"}).calculate
      expect(results).to eq(milk_promo)
    end
  end

end
