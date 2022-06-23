require_relative 'csv_report'

class LocationReport < CsvReport
  def self.headers
    %w[
        provider
        delivery_mode
        lad
    ]
  end
end
