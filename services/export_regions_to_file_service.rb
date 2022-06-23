require 'csv'

require_relative 'export_to_file_service_base'
require_relative 'export_regions_service'

# This service is used to export UK regions to a CSV file.
class ExportRegionsToFileService < ExportToFileServiceBase

  def initialize(path)
    super(ExportRegionsService, path, objects: Region::ENGLAND)
  end
end
