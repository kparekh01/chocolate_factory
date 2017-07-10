require_relative 'promotion'

class DarkPromo < Promotion
  def calculate
    if @wrappersneeded >= 1
      @dark_wrapper_count = @current_wrappers
      while (@dark_wrapper_count >= @wrappersneeded)
        wrappers_redeemed = @dark_wrapper_count.divmod(@wrappersneeded)
        @redemptions["dark"] += wrappers_redeemed[0]
        @dark_wrapper_count = wrappers_redeemed.inject(:+)
      end
      return ["milk #{@redemptions["milk"]}", " dark #{@redemptions["dark"]}", " white #{@redemptions["white"]}", " sugar free #{@redemptions["sugarfree"]}"]
    else
      return ["milk #{@redemptions["milk"]}", " dark #{@redemptions["dark"]}", " white #{@redemptions["white"]}", " sugar free #{@redemptions["sugarfree"]}"]
    end
  end
end
