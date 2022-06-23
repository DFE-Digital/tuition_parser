require 'csv'

require_relative 'export_service_base'
require_relative '../reports/provider_report'

# Service to export data
class ExportProvidersService < ExportServiceBase
  def initialize(providers)
    super(ProviderReport, objects: providers)
  end
end
