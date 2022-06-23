require 'csv'

require_relative 'application_service'

class CsvReportService < ApplicationService
  def initialize(report_class, objects:)
    @report_class = report_class
    @objects = objects
  end

  def call
    write_to_csv
  end

private

  attr_accessor :report_class, :path, :csv, :objects

  def write_to_csv
    CSV.generate do |csv|
      report_class.new(csv, objects:).generate_report
      @csv = csv
    end
  end
end
