# frozen_string_literal: true

module DigitalDocument
  class PDF
    ZERO_FILLER = Object.new.tap do |obj|
      def obj.inspect
        "ZERO_FILLER"
      end
    end.freeze

    attr_reader :version, :objects, :trailer
    private attr_reader :readonly
    private attr_writer :version, :objects, :trailer, :readonly

    def initialize(objects = [], version = "1.7")
      self.readonly = false
      self.version = version
      self.objects = [ZERO_FILLER, *objects]
    end

    def finalize_document!
      return if readonly?

      self.readonly = true
      objects.freeze

      catalog_index = objects.find_index { |obj| obj.is_a?(Hash) && obj[:Type] == :Catalog }
      raise "PDF has no Catalog object" if catalog_index.nil?

      self.trailer = {Size: objects.size, Root: Reference.new(catalog_index)}.freeze
    end

    def readonly?
      readonly
    end

    def next_id
      objects.size
    end
  end
end
