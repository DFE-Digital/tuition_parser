# frozen_string_literal: true

require_relative 'file_parser/error'

class FileParser
  attr_reader :filename, :provider, :prices, :locations

  SHEETS = {
    provider: {
      sheet_name: 'General Information',
      coordinates: {
        display_name: ['C', 3],
        ntp_url: ['C', 4],
        email_address: ['D', 5],
        phone_number: ['D', 6],
        website_url: ['D', 7],
        address: ['D', 8],
        svg_logo: ['G', 15],
        f2f_delivery_description: ['C', 15],
        f2f_delivery_experience: ['E', 15],
        f2f_delivery_legal_status: ['F', 15],
        f2f_delivery_additional_offerings: ['H', 15],
        online_delivery_description: ['C', 16],
        online_delivery_experience: ['E', 16],
        online_delivery_legal_status: ['F', 16],
        online_delivery_additional_offerings: ['H', 16],
      },
      mandatory: %i[display_name],
    },
    prices: {
      sheet_name: 'Pricing, Key Stage and SEN',
      coordinates: {
        f2f: ['C', 14],
        online: ['C', 24],
      },
    },
    locations: {
      sheet_name: 'Location of Tuition Provision',
      coordinates: {
        f2f: ['E', 24],
        online: ['F', 24],
      },
    },
  }

  ALL = %w[ALL A all a]
  YES = %w[Yes Y yes y]
  NO  = %w[No N no n]

  def initialize(filename)
    @filename = filename
    @xlsx = Roo::Spreadsheet.open(filename)
    @sheets = {}
    initialize_models
    parse_provider
    parse_prices
    parse_locations
  end

  def none?
    visits.empty?
  end

  private

  attr_reader :xlsx, :model

  def coordinates
    props[:coordinates]
  end

  def initialize_models
    puts "Processing #{filename}"
    @provider = {}
    @prices = []
    @locations = []
  end

  def lad_names
    @lad_names ||= LocalAuthorityDistrict.names
  end

  def lad_name(value)
    lad_names.include?(value) ? value : LocalAuthorityDistrict.lad_of_code(value)&.dig(:name)
  end

  def lads(col, row)
    value = sheet.cell(col.next.next.next.next, row)
    names = value.present? ? value.tr("\n", ";").split(/[\;\:]+/).map(&:strip) : []
    validate_lads!(*names)
  end

  def location(delivery_mode:, lad:)
    {
      provider: provider[:display_name],
      delivery_mode:,
      lad:
    }
  end

  def mandatory_fiels
    props[:mandatory]
  end

  def parse_locations
    @model = :locations
    @locations = coordinates.each_with_object([]) do |(delivery_mode, (col, row)), locations|
      next locations.push(location(delivery_mode:, lad: 'All')) if YES.include?(sheet.cell(col, row))

      lads = lads(col, row)
      region_names = regions(col, row)
      lads = LocalAuthorityDistrict.names(*region_names) if (lads.empty? || ALL.include?(lads)) && region_names.present?
      lads.each { |lad| locations.push(location(delivery_mode:, lad:)) }
    end
  end

  def parse_prices
    @model = :prices
    @prices = coordinates.each_with_object([]) do |(delivery_mode, (col, row)), prices|
      loop do
        key_stage, subject = sheet.cell(col, row)&.split('Key Stage ')&.last&.split(' - ')
        break unless [key_stage, subject].all?(&:present?)
        subject = subject.chomp('*').chomp('*').chomp('*')

        prices.push(*prices_from(delivery_mode:, key_stage:, subject:, col:, row:))
        col = col.next
      end
    end
  end

  def parse_provider
    @model = :provider
    @provider = coordinates.map do |key, (col, row)|
      [key, sheet.cell(col, row)]
    end.to_h
    validate_provider!
  end

  def price?(price)
    price.present? && price.to_s.strip !~ /(NA|N\/A|na|n\/a|Not|not)/
  end

  def prices_from(delivery_mode:, key_stage:, subject:, col:, row:)
    (1..6).map do |group_size|
      price = sheet.cell(col, row + group_size)
      {
        provider: provider[:display_name],
        delivery_mode:,
        key_stage:,
        subject:,
        group_size:,
        price:
      } if price?(price)
    end.compact
  end

  def props
    SHEETS[model]
  end

  def region?(value)
    Region.names.include?(value) || Region.codes.include?(value)
  end

  def regions(col, row)
    names = Array(sheet.cell(col.next.next, row)&.tr("\n", ",")&.split(/[\,]+/)&.map(&:strip))
    validate_regions!(*names)
  end

  def sheet
    @sheets[model] ||= xlsx.sheet(props[:sheet_name])
  end

  def validate_lads!(*names)
    names.map do |name|
      lad_name(name) || raise(FileParser::Error.new(filename, error: "#{name} is not a valid LAD name"))
    end
  end

  def validate_provider!
    mandatory_fiels.each do |field|
      raise FileParser::Error.new(filename, error: "#{field} can't be blank") if provider[field].blank?
    end
  end

  def validate_regions!(*values)
    values.each do |value|
      raise FileParser::Error.new(filename, error: "#{value} is not a valid Region") unless region?(value)
    end
  end
end
