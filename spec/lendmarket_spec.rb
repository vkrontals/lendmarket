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

  describe "#new" do

    it "raises exception if not enough money is available" do
      expect { Lendmarket::Quote.new({ amount: 15000, term: 36, markets: markets }) }
        .to raise_error Lendmarket::NotEnoughMoney
    end

    it "raises exception if amount is invalid" do
      [50, 110, -100, 16000, 'test', '@£$@'].each do |amount|
        expect { Lendmarket::Quote.new({ amount: amount, term: 36, markets: markets }) }
          .to raise_error Lendmarket::InvalidAmount
      end

    end

  end

  describe "#total_repayment" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it { expect(quote.send :total_repayment).to be_within(0.01).of(1108.10) }

  end

  describe "#rate" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it { expect(quote.send :rate).to be_within(0.01).of(0.07) }
  end

  describe "#monthly_repayment" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it { expect(quote.send :monthly_repayment).to be_within(0.01).of(30.78) }
  end

  describe "#monthly_rate" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it { expect(quote.send :monthly_rate).to be_within(0.001).of(0.005) }
  end

  describe "#marketify" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it 'returns an array of markets' do
      marketified = quote.send:marketify, markets
      expect(marketified.length).to be(233)

      marketified.each do |m|
        expect(m.respond_to?(:rate)).to be true
        expect(m.respond_to?(:available)).to be true
      end

    end

  end

  describe "#money_available" do
    let(:quote) { Lendmarket::Quote.new({ amount: 1000, term: 36, markets: markets }) }

    it { expect(quote.send :money_available).to eq 2330 }
  end

end
