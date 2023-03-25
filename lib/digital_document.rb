# frozen_string_literal: true

require_relative "digital_document/version"
require_relative "digital_document/pdf"
require_relative "digital_document/pdf/reference"
require_relative "digital_document/pdf/save"
require_relative "digital_document/pdf/stream"

module DigitalDocument
  class Error < StandardError; end
  # Your code goes here...
end
