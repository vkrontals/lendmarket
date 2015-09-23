require 'spec_helper'

describe Lendmarket::Quote do

  let (:lendmarket) { Lendmarket::Quote.new }

  describe "#calculate" do
    let (:correct_quote) {
<<outpt
Requested amount: £1000
Rate: 7.0%
Monthly repayment: £30.78
Total repayment: £1108.10
outpt
}
    it "returns a correct quote" do
      expect { lendmarket.calculate }.to output(correct_quote).to_stdout
    end
  end
end
