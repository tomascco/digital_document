# frozen_string_literal: true

module DigitalDocument
  class PDF
    class Reference
      attr_reader :id, :version
      private attr_writer :id, :version

      def initialize(id, version = 0)
        self.id = Integer(id)
        self.version = Integer(version)
      end
    end
  end
end
