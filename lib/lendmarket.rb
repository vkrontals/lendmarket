require "lendmarket/version"
require "lendmarket/exceptions"
require "lendmarket/formulas"

module Lendmarket
  class Quote
    include Excel::Formulas
    attr_reader :amount, :markets, :term

    VALID_AMOUNT = (1000..15000).step(100).to_a
    Market = Struct.new( :rate, :available)

    def initialize(args)
      raise Lendmarket::InvalidAmount unless VALID_AMOUNT.include?(args[:amount])

      @amount = args[:amount]
      @markets = marketify args[:markets]
      @term = args[:term]
      raise Lendmarket::NotEnoughMoney if amount > money_available
    end

    def calc
      {
        requested_amount: amount,
        rate: (rate * 100).round(1),
        monthly_repayment: monthly_repayment.round(2),
        total_repayment: total_repayment.round(2)
      }
    end

    def print
      puts "Requested amount: £%d" % amount
      puts "Rate: %.1f%" % (rate * 100)
      puts "Monthly repayment: £%.2f" % monthly_repayment.round(2)
      puts "Total repayment: £%.2f" % total_repayment
    end

    private

    def total_repayment
      monthly_repayment * term
    end

    def rate
      val = sorted_markets
       .reduce([]) do |result, market|
         result << market if money_available(result) < amount
         result
       end

      val.reduce(0) { |sum, n| sum + n.rate } / val.length
    end

    def money_available(markets_array = markets)
      markets_array.reduce(0) { |sum, n| sum + n.available }
    end

    def monthly_repayment
      pmt(monthly_rate, term, -amount)
    end

    def monthly_rate
      (1 + rate) ** (1 / 12.0) - 1
    end

    def marketify(markets_array)
      markets_array.reduce([]) do |result, lender|
        (lender[:available] / 10).times do
          result << Market.new(lender[:rate], 10)
        end

        result
      end
    end

    def sorted_markets
      markets.sort_by { |x| x[:rate] }
    end

  end

end
