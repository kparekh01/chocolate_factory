require 'sugarfree_promo'

describe "SugarFreePromo" do

  context "Initializing a sugarfree promotion order with any invalid hash" do
    it 'returns This order is invalid' do
      expect{SugarFreePromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"2", :type=>"sugarfree"})}.to raise_error("This order is invalid")
      expect{SugarFreePromo.new({:cash=>"12", :price=>"0", :wrappersneeded=>"4", :type=>"sugarfree"})}.to raise_error("This order is invalid")
      expect{SugarFreePromo.new({:cash=>"0", :price=>"2", :wrappersneeded=>"10", :type=>"caramel"})}.to raise_error("This order is invalid")
    end
  end

  context "Calling calculate on a valid initialized sugarfree promotion order hash with 0 wrappers needed" do
    it "returns an array with only number of sugarfree chocolates purchased" do
      sugarfree_promo = SugarFreePromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"0", :type=>"sugarfree"})
      redemptions = sugarfree_promo.redemptions
      array = ["milk 0", " dark 0", " white 0", " sugar free #{sugarfree_promo.chocolates_purchased}"]
      expect(array).to eq(sugarfree_promo.calculate)
    end
  end

  context "Calling calculate on a valid initialized sugarfree promotion order hash with cash 12, price 3 and wrappersneeded 3" do
    it "calculates the sugarfree promotion and returns an array containing additional sugarfree and dark chocolates.
        It does not calculate the dark promotion if sugarfree promotion generates less than 3 dark chocolates." do
      results = ["milk 0", " dark 1", " white 0", " sugar free 5"]
      sugarfree_promo = SugarFreePromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"3", :type=>"sugarfree"}).calculate
      expect(results).to eq(sugarfree_promo)
    end
  end

  context "Calling calculate on a valid initialized sugarfree promotion order hash with cash 12, price 3 and wrappersneeded 2" do
    it "calculates both the sugarfree and dark promotion if there are more than 2 chocolates of each type.
        Returns an array containing additional sugarfree and additional dark chocolates." do
      results = ["milk 0", " dark 5", " white 0", " sugar free 7"]
      sugarfree_promo = SugarFreePromo.new({:cash=>"12", :price=>"3", :wrappersneeded=>"2", :type=>"sugarfree"}).calculate
      expect(results).to eq(sugarfree_promo)
    end
  end

end
