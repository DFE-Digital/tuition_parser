require_relative 'csv_report'

class LadReport < CsvReport
  def self.headers
    %w[code name region]
  end
end
