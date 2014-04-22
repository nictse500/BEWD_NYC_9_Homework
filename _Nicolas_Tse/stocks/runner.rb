require_relative 'lib/Portfolio'

def greet
	puts "Welcome to your virtual portfolio."
end
def instruction
	puts "Commands:"
	puts "   Add position: [buy|sell] [shares] [stock symbol]"
	puts "   Current status: status"
	puts "   Quit: quit"
end
greet
instruction
portfolio = Portfolio.new()
command = []
while command.first != "quit" do
	command = gets.split(' ').map {|x| x.downcase.chomp}
	if command.first == "status"
		portfolio.print_status
	elsif ["buy", "sell"].include? command.first
		if command.length != 3 then 
			puts "Please enter number of shares and the stock symbol"
			instruction
		else
			action = command[0]
			shares = command[1].to_i
			symbol = command[2].upcase
			if action == "buy"
				portfolio.buy_stock(symbol, shares)
			elsif action == "sell"
				portfolio.sell_stock(symbol, shares)
			end
		end
	elsif command.first != "quit"
		puts "Invalid command."		#validation
		instruction
	end
end

puts "Summary"
portfolio.print_status
