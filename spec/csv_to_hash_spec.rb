require 'spec_helper'
require 'csv_tools'

describe Lendmarket::CSVTools do
  let(:csv_data) {
<<HERE
Lender,Rate,Available
Bob,0.075,640
Jane,0.069,480
HERE
}
  describe '#csv_to_hash' do
    it 'converts a csv file to hash' do
      expect(Lendmarket::CSVTools.csv_to_hash(csv_data)).to eq(
        [{ lender: 'Bob', rate: 0.075, available: 640 },
         { lender: 'Jane', rate: 0.069, available: 480 }])
    end

  end

end
