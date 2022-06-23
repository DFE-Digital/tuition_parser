require 'csv'

require_relative 'export_to_file_service_base'
require_relative 'export_providers_service'

# This service is used to export tuition providers to a CSV file.
class ExportProvidersToFileService < ExportToFileServiceBase
  def initialize(path, objects:)
    super(ExportProvidersService, path, objects:)
  end
end
