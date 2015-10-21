module Lendmarket

  class InvalidAmount < StandardError; end

  # when given markets don't have enough money
  class NotEnoughMoney < StandardError; end

  class NoMarketsFound < StandardError; end

end
