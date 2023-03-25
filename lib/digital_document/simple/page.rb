# frozen_string_literal: true

module DigitalDocument
  class Simple
    class Page
      attr_accessor :contents, :width, :height

      # initializes with A4 paper size
      def initialize(contents = nil, width = 595.44, height = 841.68)
        self.width = width
        self.height = height
        self.contents = contents
      end

      def contents?
        !contents.nil?
      end
    end
  end
end
