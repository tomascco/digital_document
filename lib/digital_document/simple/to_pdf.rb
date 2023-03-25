# frozen_string_literal: true

module DigitalDocument
  class Simple
    module ToPDF
      extend self

      def call(simple)
        pdf = PDF.new([
          {Type: :Catalog, Pages: DigitalDocument::PDF::Reference.new(2)},
          {Type: :Pages, Kids: [], Count: simple.pages.size}
        ])

        page_refs = []
        simple.pages.each do |page|
          next_id = pdf.next_id
          page_refs << PDF::Reference.new(next_id)

          page_obj = {
            Type: :Page,
            Parent: PDF::Reference.new(2),
            MediaBox: [0, 0, page.width, page.height]
          }
          pdf.objects << page_obj

          if page.contents?
            page_obj[:Contents] = PDF::Reference.new(next_id + 1)

            pdf.objects << PDF::Stream.new(page.contents)
          end
        end

        pdf.objects[2][:Kids] = page_refs

        pdf
      end
    end
  end
end
