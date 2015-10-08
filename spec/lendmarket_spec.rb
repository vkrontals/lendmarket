require 'spec_helper'

describe Lendmarket::Quote  do

  let (:markets) {
    [
      { lender: 'Bob'   , rate: 0.075, available: 640 },
      { lender: 'Jane'  , rate: 0.069, available: 480 },
      { lender: 'Fred'  , rate: 0.071, available: 520 },
      { lender: 'Mary'  , rate: 0.104, available: 170 },
      { lender: 'John'  , rate: 0.081, available: 320 },
      { lender: 'Dave'  , rate: 0.074, available: 140 },
      { lender: 'Angela', rate: 0.071, available: 60 }
    ]
  }

  describe "#print" do
    let (:correct_quote) {
<<outpt
Requested amount: £1000
Rate: 7.0%
Monthly repayment: £30.78
Total repayment: £1108.10
outpt
}
    it "returns a correct quote" do
      quote = Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets })

      expect { quote.print }.to output(correct_quote).to_stdout
    end

    it "raises InvalidAmount exception if amount is invalid" do
      [50, 110, -100, 16000].each do |amount|
        expect { Lendmarket::Quote.new({ amount: amount, term: 36, markets: markets }) }
          .to raise_error Lendmarket::InvalidAmount
      end

    end

  end

  describe "#total_repayment" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it 'returns correct total repayment' do
      expect(quote.total_repayment).to be_within(0.01).of(1108.18)
    end

  end

  describe "#rate" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it 'calculates the lowest rate for a given market' do
      expect(quote.rate).to be_within(0.01).of(0.07)
    end

  end

  describe "#monthly_repayment"  do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it 'calculates the monthly repayment amount' do
      expect(quote.monthly_repayment).to be_within(0.01).of(30.78)
    end

  end

  describe "#monthly_rate" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it 'calculates the monthly repayment amount' do
      expect(quote.monthly_rate).to be_within(0.001).of(0.005)
    end

  end

end
