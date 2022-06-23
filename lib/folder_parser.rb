# frozen_string_literal: true

require 'roo'
require_relative 'file_parser'

class FolderParser
  attr_reader :path, :providers, :prices, :locations

  def initialize(path)
    @path = path.strip
    initialize_models
    parse_files
  end

  def empty?
    filenames.empty?
  end

  private

  def absolute_path(filename)
    File.expand_path(File.join(path, filename))
  end

  def add_models(parser)
    providers.push(parser.provider)
    prices.push(*parser.prices)
    locations.push(*parser.locations)
  end

  def filenames
    @filenames ||= Dir["*.xlsx", base: path, sort: true]
  end

  def initialize_models
    @providers = []
    @prices    = []
    @locations = []
  end

  def parse_files
    filenames.each { |filename| process_file(filename) }
  end

  def process_file(filename)
    add_models(FileParser.new(absolute_path(filename)))
  rescue FileParser::Error
    raise
  rescue StandardError => e
    raise FileParser::Error.new(filename, error: e.message)
  end
end
