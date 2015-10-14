require 'spec_helper'

describe Lendmarket::CSVtoHash, focus: true do

  it 'converts a csv file to hash' do
    expect(Lendmarket::CSVtoHash.convert('stuff').to eq { })
  end

end
