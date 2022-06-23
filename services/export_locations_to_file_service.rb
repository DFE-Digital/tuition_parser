require 'csv'

require_relative 'export_to_file_service_base'
require_relative 'export_locations_service'

# This service is used to export tuition locations to a CSV file.
class ExportLocationsToFileService < ExportToFileServiceBase
  def initialize(path, objects:)
    super(ExportLocationsService, path, objects:)
  end
end
