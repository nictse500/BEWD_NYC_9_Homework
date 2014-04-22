require 'yahoofinance'
#require_relative 'stock'
require 'pp'

class YahooFinanceApi
    quote_type = YahooFinance::StandardQuote

    def get_stock_info(quote_symbol)
        quote_symbol.upcase!
        quote_symbol.strip!

        # THIS IS TO FACILITATE TESTING OFFLINE
        offline = false
        if offline then
            #return Stock.new(quote_symbol, "Google Inc.", 535.5, 3590234, -19.4)
            return {
                symbol:  quote_symbol,
                company: quote_symbol + " Inc.",
                price:   (1...10).to_a.sample.to_f,
                volume:  3500000,
                change:  (-10...10).to_a.sample,
            }
    	end
        # ++++++++++++++++++++++++++++++++++++++++++++++++ #

        res = YahooFinance::get_quotes( @quote_type, quote_symbol )[quote_symbol]
        #Stock.new(res.symbol, res.name, res.lastTrade, res.volume, res.changePoints)
        {
            symbol:  res.symbol,
            company: res.name,
            price:   res.lastTrade,
            volume:  res.volume,
            change:  res.changePoints,
        }
    end

    def print_historical_30(quote_symbol)
    	quote_symbol.capitalize!.strip!
        YahooFinance::get_HistoricalQuotes_days( quote_symbol, 30 ) do |hq|
            puts "#{hq.symbol}\t#{hq.date}\t#{hq.open}\t#{hq.high}\t#{hq.low}\t#{hq.close}\t#{hq.volume}\t#{hq.adjClose}"
        end
    end
end

# quote_symbols = gets
# yahooFinanceApi = YahooFinanceApi.new()
# results = yahooFinanceApi.get_stock_info(quote_symbols)
# pp(results)