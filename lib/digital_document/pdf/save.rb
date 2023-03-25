# frozen_string_literal: true

module DigitalDocument
  class PDF
    module Save
      extend self

      def to_io(io, pdf:)
        pdf.finalize_document!

        io.puts("%PDF-#{pdf.version}")

        xref_table = []
        pdf.objects[1..].each_with_index do |obj, index|
          xref_table.push(io.pos)

          io << "#{index + 1} 0 obj\n"
          io << serialize(obj)
          io << "\n"
        end

        xref_pos = io.pos

        io.puts("xref")
        io.puts("0 #{pdf.objects.size}")
        io.puts("0000000000 65535 f")
        xref_table.each do |entry|
          io.puts("#{format("%010d", entry)} 00000 n")
        end

        io.puts("trailer")
        io.puts(serialize(pdf.trailer))

        io.puts("startxref")
        io.puts(xref_pos)

        io.puts("%%EOF")

        io
      end

      def to_file(path, pdf:)
        File.open(path, "wb") do |file|
          to_io(file, pdf:)
        end
      end

      private

      def serialize(obj)
        case obj
        when Hash
          serialized_pairs = obj.map { |key, value| "#{serialize(key)} #{serialize(value)}" }
          "<<#{serialized_pairs.join(" ")}>>"
        when Symbol
          "/#{obj}"
        when Array
          serialized_objs = obj.map { serialize(_1) }

          "[#{serialized_objs.join(" ")}]"
        when Reference
          "#{obj.id} #{obj.version} R"
        when String
          "(#{obj})"
        when TrueClass
          "true"
        when FalseClass
          "false"
        when Numeric
          obj.to_s
        when NilClass
          "null"
        when Stream
          <<~OBJECT.chomp
            #{serialize(obj.dictionary)}
            stream
            #{obj.data}
            endstream
          OBJECT
        else
          raise NotImplementedError.new("Don't know how to serialize #{obj}")
        end
      end
    end
  end
end
