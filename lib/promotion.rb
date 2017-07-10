
class Promotion
  attr_accessor :redemptions, :milk_wrapper_count , :dark_wrapper_count, :white_wrapper_count, :sf_wrapper_count,
                :current_wrappers, :chocolates_purchased, :csv_output_row
  attr_reader   :cash, :price, :wrappersneeded, :type

  def initialize(hash)
    valid_type_array = %w[sugarfree dark milk white]
    if hash[:price].to_i == 0 || hash[:cash].to_i == 0 || !(valid_type_array.include?(hash[:type]))
      raise ArgumentError.new("This order is invalid")
    else
      @cash = hash[:cash].to_i
      @price = hash[:price].to_i
      @type = hash[:type]
      @wrappersneeded = hash[:wrappersneeded].to_i
      @chocolates_purchased =  @cash / @price
      @current_wrappers = @chocolates_purchased
      @redemptions = {"milk" => 0, "dark" => 0, "white" => 0, "sugarfree" => 0}
      @redemptions[@type] += @chocolates_purchased
      @milk_wrapper_count = 0
      @dark_wrapper_count = 0
      @white_wrapper_count = 0
      @sf_wrapper_count = 0
    end
  end
end
