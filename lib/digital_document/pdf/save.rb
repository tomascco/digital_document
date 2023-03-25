# frozen_string_literal: true

module DigitalDocument
  class PDF
    module Save
      extend self

      def call(path, pdf:)
        pdf.finalize_document! if !pdf.readonly?

        file = File.open(path, "wb")

        file.puts("%PDF-#{pdf.version}")

        xref_table = []
        pdf.objects[1..].each_with_index do |obj, index|
          xref_table.push(file.pos)

          file << "#{index + 1} 0 obj\n"
          file << serialize(obj)
          file << "\n"
        end

        xref_pos = file.pos

        file.puts("xref")
        file.puts("0 #{pdf.objects.size}")
        file.puts("0000000000 65535 f")
        xref_table.each do |entry|
          file.puts("#{format("%010d", entry)} 00000 n")
        end

        file.puts("trailer")
        file.puts(serialize(pdf.trailer))

        file.puts("startxref")
        file.puts(xref_pos)

        file.puts("%%EOF")

        file.close
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
