require_relative 'YahooFinanceApi'
require 'pp'
class Stock
	attr_accessor :symbol, :company
	def initialize(symbol)
		@YAHOO_FIN_API = YahooFinanceApi.new()
		@symbol  = symbol

		info = get_info
		@company = info[:company]
		@price   = info[:price]
		@volume  = info[:volume]
		@change  = info[:change]
	end
	def get_info
		@YAHOO_FIN_API.get_stock_info(@symbol)
	end
	def update_info
		info = get_info
		@price  = info.price
		@volume = info.volume
		@change = info.change
	end
	def price
		p = get_info[:price]
		#puts "   #{p}"
		#p
	end
	def volume
		get_info[:volume]
	end
	def change
		get_info[:change]
	end
	def to_s
		"#{@company}\t#{price}\t(#{change}) "
	end
end

# s = Stock.new("GOOG")
# puts s.price
# puts s.price