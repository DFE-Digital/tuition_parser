require 'csv'

require_relative 'export_service_base'
require_relative '../reports/price_report'

class ExportPricesService < ExportServiceBase
  def initialize(prices)
    super(PriceReport, objects: prices)
  end
end
