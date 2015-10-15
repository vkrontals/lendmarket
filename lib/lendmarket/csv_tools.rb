require 'csv'

module Lendmarket
  module CSVTools

    def self.csv_to_hash(csv_data)
      csv_data = CSV.parse(csv_data)
      keys = csv_data.shift.map{ |x| x.downcase.to_sym }
      csv_data.map {|a| Hash[ keys.zip(a.map{ |x| numberify(x) })] }
    end

    def self.numberify(str)
       return Number(str) if self =~ /\A\d+\Z/
       begin
         Float(str)
       rescue
         str
       end
    end

  end

end
