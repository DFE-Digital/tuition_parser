require_relative 'csv_report'

class ProviderReport < CsvReport
  def self.headers
    %w[
        display_name
        ntp_url
        email_address
        phone_number
        website_url
        address
        legal_status
        svg_logo
        f2f_delivery_description
        f2f_delivery_experience
        f2f_delivery_additional_offerings
        online_delivery_description
        online_delivery_experience
        online_delivery_additional_offerings
    ]
  end

private

  def csv_row(object)
    [
      object[:display_name],
      object[:ntp_url],
      object[:email_address],
      object[:phone_number],
      object[:website_url],
      object[:address],
      object[:f2f_delivery_legal_status].presence || object[:online_delivery_legal_status].presence,
      object[:svg_logo],
      object[:f2f_delivery_description],
      object[:f2f_delivery_experience],
      object[:f2f_delivery_additional_offerings],
      object[:online_delivery_description],
      object[:online_delivery_experience],
      object[:online_delivery_additional_offerings],
    ]
  end
end
