require 'csv'

require_relative 'application_service'

# This service is used to export users to a CSV file.
class ExportToFileServiceBase < ApplicationService
  def initialize(report_service, path, objects:)
    @path = path
    @report_service = report_service
    @objects = objects
  end

  def call
    raise 'No path specified' if path.nil?

    File.write(path, report_service.call(objects))
  end

private

  attr_reader :path, :report_service, :objects
end
