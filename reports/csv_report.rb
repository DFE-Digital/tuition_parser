class CsvReport
  def initialize(csv, objects:)
    @csv = csv
    @objects = objects
  end

  def generate_report
    add_headers
    add_report_rows
  end

private

  attr_accessor :csv, :objects

  def add_headers
    csv << self.class.headers
  end

  def add_object_to_csv(csv, object)
    csv << csv_row(object)
  end

  def add_report_rows
    objects.each do |object|
      add_object_to_csv(csv, object)
    end
  end

  def csv_row(object)
    object.values_at(*self.class.headers.map(&:to_sym))
  end
end
