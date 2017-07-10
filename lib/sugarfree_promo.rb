require_relative 'promotion'

class SugarFreePromo < Promotion
  def calculate
    if @wrappersneeded >= 1
      @sf_wrapper_count = @current_wrappers
      while (@sf_wrapper_count >= @wrappersneeded ||  @dark_wrapper_count >= @wrappersneeded)
        wrappers_redeemed = @sf_wrapper_count.divmod(@wrappersneeded)
        @redemptions["sugarfree"] += wrappers_redeemed[0]
        @redemptions["dark"] += wrappers_redeemed[0]
        @sf_wrapper_count = wrappers_redeemed.inject(:+)
        @dark_wrapper_count += wrappers_redeemed[0]
          if @dark_wrapper_count >= @wrappersneeded
            dark_wrappers_redeemed = dark_wrapper_count.divmod(wrappersneeded)
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
