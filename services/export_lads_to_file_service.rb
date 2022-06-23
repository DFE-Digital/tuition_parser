require 'csv'
require_relative 'export_to_file_service_base'
require_relative 'export_lads_service'

# This service is used to export England Local Authority Districts to a CSV file.
class ExportLadsToFileService < ExportToFileServiceBase

  def initialize(path)
    super(ExportLadsService, path, objects: LocalAuthorityDistrict::ENGLAND)
  end
end
