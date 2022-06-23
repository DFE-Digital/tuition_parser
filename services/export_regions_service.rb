require 'csv'

require_relative 'export_service_base'
require_relative '../reports/region_report'

class ExportRegionsService < ExportServiceBase
  def initialize(regions)
    super(RegionReport, objects: regions)
  end
end
