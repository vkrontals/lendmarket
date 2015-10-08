module Lendmarket
  class BestRate
    def calculate(markets, amount)

      val = markets.sort_by { |x| x[:rate] }.reduce({ total_available: 0, weighted_rate: 0 }) do |x, y|
        if x[:total_available] < amount
          x[:total_available] += y[:available]
          x[:weighted_rate] += y[:rate] * y[:available]
        end

        x
      end

      #return p 'not enough money in pot' if amount > val[:total_available]

      val[:weighted_rate] / val[:total_available]
    end

  end

end

