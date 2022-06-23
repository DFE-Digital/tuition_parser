#!/usr/bin/env ruby
# frozen_string_literal: true

require 'byebug'
require 'active_support'
require_relative '../lib/folder_parser'
require_relative '../lib/local_authority_district'
require_relative '../lib/region'
require_relative '../services/export_providers_to_file_service'
require_relative '../services/export_prices_to_file_service'
require_relative '../services/export_regions_to_file_service'
require_relative '../services/export_lads_to_file_service'
require_relative '../services/export_locations_to_file_service'

puts "Installing dependencies..."
system('bundle install &> /dev/null')

begin
  if ARGV[0].blank?
    puts "Please add the path to the folder with the files to parse. Ex: $> ./bin/parse path_to_folder"
    exit(-1)
  end
  data = FolderParser.new(ARGV[0])
rescue StandardError => e
  puts e.message
  exit(-1)
end

if data.empty?
  puts "There are no files to parse!"
else
  providers_filename = File.expand_path(File.join(ARGV[0], 'providers.csv'))
  prices_filename    = File.expand_path(File.join(ARGV[0], 'prices.csv'))
  regions_filename   = File.expand_path(File.join(ARGV[0], 'regions.csv'))
  lads_filename      = File.expand_path(File.join(ARGV[0], 'lads.csv'))
  locations_filename = File.expand_path(File.join(ARGV[0], 'locations.csv'))

  ExportProvidersToFileService.call(providers_filename, objects: data.providers)
  puts "Providers: #{data.providers.size} (Check generated file: #{providers_filename})"

  ExportPricesToFileService.call(prices_filename, objects: data.prices)
  puts "Prices: #{data.prices.size} (Check generated file: #{prices_filename})"

  ExportRegionsToFileService.call(regions_filename)
  puts "Regions: #{Region::ENGLAND.size} (Check generated file: #{regions_filename})"

  ExportLadsToFileService.call(lads_filename)
  puts "LADs: #{LocalAuthorityDistrict::ENGLAND.size} (Check generated file: #{lads_filename})"

  ExportLocationsToFileService.call(locations_filename, objects: data.locations)
  puts "Locations: #{data.locations.size} (Check generated file: #{locations_filename})"
end
