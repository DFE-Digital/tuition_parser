require 'csv'

require_relative 'export_service_base'
require_relative '../reports/location_report'

class ExportLocationsService < ExportServiceBase
  def initialize(locations)
    super(LocationReport, objects: locations)
  end
end
