require 'csv'

require_relative 'application_service'
require_relative 'csv_report_service'

# Service to export data
class ExportServiceBase < ApplicationService
  def initialize(report_class, objects:)
    @report_class = report_class
    @objects = objects
  end

  def call
    CsvReportService.call(report_class, objects:)
  end

private

  attr_reader :report_class, :objects
end
