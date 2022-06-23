# frozen_string_literal: true

class FileParser
  class Error < StandardError
    attr_reader :file

    def initialize(filename, error: nil)
      @filename = filename
      @error = error
    end

    def message
      error ? [base_message, error].join(': ') : base_message
    end

    def base_message
      "Error loading file #{filename}"
    end

    private

    attr_reader :filename, :error
  end
end
