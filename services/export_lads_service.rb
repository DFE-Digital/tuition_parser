require 'csv'

require_relative 'export_service_base'
require_relative '../reports/lad_report'

class ExportLadsService < ExportServiceBase
  def initialize(lads)
    super(LadReport, objects: lads)
  end
end
