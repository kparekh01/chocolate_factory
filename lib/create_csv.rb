require 'csv'
require_relative 'orders'
require_relative 'white_promo'
require_relative 'milk_promo'
require_relative 'dark_promo'
require_relative 'sugarfree_promo'

#In terminal require 'CreateCsvFile' then run the following commands CreateCsvFile.new.run

class CreateCsvFile
  attr_reader :input_csv_file, :output_csv_file
  def initialize
    @input_csv_file = CSV.read("../input/orders.csv")
    @output_csv_file = "../output/redemptions.csv"
  end

  def run
    @orders = Orders.new(@input_csv_file).generate_order_array
    CSV.open(@output_csv_file, "wb") do |csv|
      @orders.each do |hash|
        if hash[:type] == "milk"
          csv << MilkPromo.new(hash).calculate
        elsif hash[:type] == "white"
          csv << WhitePromo.new(hash).calculate
        elsif hash[:type] == "sugarfree"
          csv << SugarFreePromo.new(hash).calculate
        elsif hash[:type] == "dark"
          csv << DarkPromo.new(hash).calculate
        end
      end
    end
  end
end

CreateCsvFile.new.run
puts "Your redemptions.csv file has been successfully created and is located in the output directory"
