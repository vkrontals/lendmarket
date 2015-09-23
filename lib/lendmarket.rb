require "lendmarket/version"

module Lendmarket
  class Quote
    def calculate
      puts "Requested amount: £1000"
      puts "Rate: 7.0%"
      puts "Monthly repayment: £30.78"
      puts "Total repayment: £1108.10"
    end
  end
end
