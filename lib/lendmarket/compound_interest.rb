require 'formulas'

module Lendmarket
  class LoanCalculator
    include Excel::Formulas

    def compound_interest(amount, rate, term)
      term.times do
        amount = amount * (1 + monthly_rate(rate))
      end

      amount
    end

    def repayments(rate, term, amount)
      pmt(monthly_rate(rate), term, -amount)
    end

    def monthly_rate(rate)
      (1 + rate) ** (1 / 12.0) - 1
    end

  end

end
