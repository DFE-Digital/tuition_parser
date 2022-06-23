module Region
  ENGLAND = [
    { code: 'SW', name:	'South West' },
    { code: 'SE', name: 'South East' },
    { code: 'L',  name: 'London' },
    { code: 'EM', name: 'East Midlands' },
    { code: 'WM', name: 'West Midlands' },
    { code: 'YH', name: 'Yorkshire & Humber' },
    { code: 'NW', name: 'North West' },
    { code: 'NE', name: 'North East' },
    { code: 'E',  name: 'East England' },
  ].freeze

  def self.names
    @names ||= ENGLAND.map { |region| region[:name] }
  end

  def self.codes
    @codes ||= ENGLAND.map { |region| region[:code] }
  end
end
