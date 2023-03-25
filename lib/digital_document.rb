# frozen_string_literal: true

require_relative "digital_document/version"
require_relative "digital_document/pdf"
require_relative "digital_document/pdf/reference"
require_relative "digital_document/pdf/save"
require_relative "digital_document/pdf/stream"

require_relative "digital_document/simple/"
require_relative "digital_document/simple/page"
require_relative "digital_document/simple/to_pdf"

module DigitalDocument
  class Error < StandardError; end
  # Your code goes here...
end
