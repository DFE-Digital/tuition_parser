require 'csv'

require_relative 'export_to_file_service_base'
require_relative 'export_prices_service'

# This service is used to export tuition prices to a CSV file.
class ExportPricesToFileService < ExportToFileServiceBase
  def initialize(path, objects:)
    super(ExportPricesService, path, objects:)
  end
end
