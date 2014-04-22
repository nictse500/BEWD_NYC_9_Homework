require_relative 'YahooFinanceApi'
require_relative 'Stock'
require 'pp'

class Portfolio 

	class Position
		attr_accessor :stock, :cost_basis, :shares, :last_transaction_price
		def initialize(symbol, shares)
			@stock = Stock.new(symbol)
			#puts stock
			@last_transaction_price = @stock.price
			@cost_basis = @last_transaction_price * shares
			@shares = shares
		end
		def cost
			@cost_basis / @shares.abs
		end
		def add_to_position(shares)
			@last_transaction_price = @stock.price
			@cost_basis += (@last_transaction_price * shares)
			@shares += shares
		end
		def to_s 
			def get_signed_num(num)
				("±+-"[num <=> 0]) + "#{num.abs}"
			end
			(shares > 0 ? "Long" : "Short") + " #{@shares.abs} shares of #{@stock.company} at $#{cost.round(2)} ("+get_signed_num(value.round(2))+")"

		end
		def value
			if @shares > 0 then
				@stock.price - cost
			else
				cost + @stock.price
			end
		end
	end

	attr_accessor :position_list, :cash
	def initialize
		@cash = 0.0
		@position_list = {}
	end

	def buy_stock(symbol, shares)
    	executed_price = buy_stock_wrapper(symbol, shares)
    	puts "Bought #{shares} #{symbol} at $#{executed_price}"
    end
    def sell_stock(symbol, shares)
    	executed_price = buy_stock_wrapper(symbol, shares * -1)
    	puts "Sold #{shares} #{symbol} at $#{executed_price}"
    end
    def buy_stock_wrapper(symbol, shares)
		if @position_list.has_key?(symbol) then
			@position_list[symbol].add_to_position(shares)
		else
			@position_list[symbol] = Position.new(symbol, shares)
		end
		executed_price = @position_list[symbol].last_transaction_price
		if @position_list[symbol].shares == 0 then
			@cash += @position_list[symbol].cost_basis * -1
			@position_list.delete(symbol)
		end
		executed_price
	end
    # def total_value
    # 	value = @cash
    # end
    def print_status
    	puts "Cash $#{@cash}"
    	@position_list.each do |symbol, position|
    		puts position
    	end
    	puts "Total value of positions #{value}"
    end
    def value
    	value = 0
    	@position_list.each { |symbol, position|
    		value += position.value
    	}
    	value
    end
end

# port = Portfolio.new()
# port.buy_stock("GOOG", 10)
# port.buy_stock("GOOG", 20)
# port.sell_stock("YHOO", 10)
# port.sell_stock("GOOG", 5)
# port.buy_stock("YHOO", 10)
# port.buy_stock("TSLA", 7)
# port.sell_stock("TSLA", 2)
# port.sell_stock("AAPL", 30)
# port.print_status