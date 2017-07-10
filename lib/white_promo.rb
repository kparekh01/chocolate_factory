require_relative 'promotion'

class WhitePromo < Promotion
  def calculate
    if @wrappersneeded >= 1
      @white_wrapper_count = @current_wrappers
      while (@white_wrapper_count >= @wrappersneeded || @sf_wrapper_count >= @wrappersneeded || @dark_wrapper_count >= @wrappersneeded)
        wrappers_redeemed = @white_wrapper_count.divmod(@wrappersneeded)
        @redemptions["white"] += wrappers_redeemed[0]
        @redemptions["sugarfree"] += wrappers_redeemed[0]
        @white_wrapper_count = wrappers_redeemed.inject(:+)
        @sf_wrapper_count += wrappers_redeemed[0]
          if @sf_wrapper_count >= @wrappersneeded
            sf_wrappers_redeemed = @sf_wrapper_count.divmod(@wrappersneeded)
            @redemptions["sugarfree"] += sf_wrappers_redeemed[0]
            @redemptions["dark"] += sf_wrappers_redeemed[0]
            @sf_wrapper_count = sf_wrappers_redeemed.inject(:+)
            @dark_wrapper_count += sf_wrappers_redeemed[0]
          end
          if @dark_wrapper_count >= @wrappersneeded
            dark_wrappers_redeemed = @dark_wrapper_count.divmod(@wrappersneeded)
            @redemptions["dark"] += dark_wrappers_redeemed[0]
            @dark_wrapper_count = dark_wrappers_redeemed.inject(:+)
          end
      end
      return ["milk #{@redemptions["milk"]}", " dark #{@redemptions["dark"]}", " white #{@redemptions["white"]}", " sugar free #{@redemptions["sugarfree"]}"]
    else
      return ["milk #{@redemptions["milk"]}", " dark #{@redemptions["dark"]}", " white #{@redemptions["white"]}", " sugar free #{@redemptions["sugarfree"]}"]
    end
  end
end
