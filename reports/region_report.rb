require_relative 'csv_report'

class RegionReport < CsvReport
  def self.headers
    %w[code name]
  end
end
