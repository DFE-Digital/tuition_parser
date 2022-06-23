require_relative 'csv_report'

class PriceReport < CsvReport
  def self.headers
    %w[
        provider
        delivery_mode
        key_stage
        subject
        group_size
        price
    ]
  end
end
