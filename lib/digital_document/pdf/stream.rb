# frozen_string_literal: true

module DigitalDocument
  class PDF
    class Stream
      attr_reader :dictionary, :data
      private attr_writer :dictionary, :data

      def initialize(data, dictionary: {})
        self.data = data
        self.dictionary = {**dictionary, Length: data.bytesize}
      end
    end
  end
end
