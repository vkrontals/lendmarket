require "lendmarket/version"
require "lendmarket/exceptions"
require "lendmarket/formulas"

module Lendmarket
  class Quote
    include Excel::Formulas
    attr_reader :amount, :markets, :term

    VALID_AMOUNT = (1000..15000).step(100).to_a

    def initialize(args)
      raise Lendmarket::InvalidAmount unless VALID_AMOUNT.include?(args[:amount])

      @amount = args[:amount]
      @markets = args[:markets]
      @term = args[:term]
    end

    def print
      puts "Requested amount: £%d" % amount
      puts "Rate: %.1f%" % (rate * 100)
      puts "Monthly repayment: £%.2f" % monthly_repayment.round(2)
      puts "Total repayment: £%.2f" % total_repayment
    end

    def total_repayment
      monthly_repayment * term
    end

    def rate
      val = sorted_markets
        .reduce({ total_available: 0, weighted_rate: 0 }) do |x, y|
          if x[:total_available] < amount
            x[:total_available] += y[:available]
            x[:weighted_rate] += y[:rate] * y[:available]
          end

        x
      end

      raise Lendmarket::NotEnoughMoney if amount > val[:total_available]

      val[:weighted_rate] / val[:total_available]
    end

    def monthly_repayment
      pmt(monthly_rate, term, -amount)
    end

    def monthly_rate
      (1 + rate) ** (1 / 12.0) - 1
    end

    private

    def sorted_markets
      markets.sort_by { |x| x[:rate] }
    end

  end

end
