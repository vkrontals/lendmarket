module Lendmarket

  # invalid amount error
  class InvalidAmount < StandardError; end

  # when given markets don't have enough money
  class NotEnoughMoney < StandardError; end

end
