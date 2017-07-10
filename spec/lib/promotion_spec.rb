require "promotion"

describe 'promotion' do

  context "Initializing a promotion order hash with no cash" do
    it 'returns This order is invalid' do
      expect{Promotion.new({:cash=>"0", :price=>"2", :wrappersneeded=>"2", :type=>"milk"})}.to raise_error("This order is invalid")
    end
  end

  context "Initializing a promotion order hash with no price" do
    it 'returns This order is invalid' do
      expect{Promotion.new({:cash=>"12", :price=>"0", :wrappersneeded=>"4", :type=>"milk"})}.to raise_error("This order is invalid")
    end
  end

  context "Initializing a promotion order hash with invalid hash type" do
    it 'returns This order is invalid' do
      expect{Promotion.new({:cash=>"0", :price=>"2", :wrappersneeded=>"10", :type=>"caramel"})}.to raise_error("This order is invalid")
    end
  end

  context "Initializing the promotion with a valid hash" do
    valid_hash = Promotion.new({:cash=>"12", :price=>"2", :wrappersneeded=>"4", :type=>"milk"})
    it 'correctly calculates the number of chocolates puchased' do
      expect(valid_hash.cash / valid_hash.price).to eq(valid_hash.chocolates_purchased)
    end
    it 'sets current wrappers to the number of chocolates purchased' do
      expect(valid_hash.chocolates_purchased).to eq(valid_hash.current_wrappers)
    end
    it "updates the redemptions hash using the valid hash's type and number of chocolates purchased" do
      redemptions = {"milk" => 0, "dark" => 0, "white" => 0, "sugarfree" => 0}
      redemptions[valid_hash.type] = valid_hash.chocolates_purchased
      expect(redemptions).to eq(valid_hash.redemptions)
    end
  end

end
