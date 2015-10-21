require 'csv'

module Lendmarket
  module CSVTools

    def self.csv_to_hash(csv_data)
      csv_data = CSV.parse(csv_data, { converters: :numeric })
      keys = csv_data.shift.map{ |x| x.downcase.to_sym }
      csv_data.map {|a| Hash[ keys.zip(a.map{ |x| x })] }
    end

  end

end
