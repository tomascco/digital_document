# frozen_string_literal: true

require "test_helper"

class DigitalDocument::PDF
  class SaveTest < Minitest::Test
    def test_pdf_creation_and_building
      # Arrange
      pdf = DigitalDocument::PDF.new([
        {Type: :Catalog, Pages: DigitalDocument::PDF::Reference.new(2)},
        {Type: :Pages, Kids: [DigitalDocument::PDF::Reference.new(3)], Count: 1},
        {Type: :Page, MediaBox: [0, 0, 595.44, 841.68], Contents: DigitalDocument::PDF::Reference.new(4)},
        DigitalDocument::PDF::Stream.new("1.0 0.0 0.0 RG\n0.5 0.75 1.0 rg\n97.72 220.84 400 400 re\nB"),
        true,
        false,
        nil,
        "Hi from PDF"
      ])
      io = StringIO.new

      # Act
      Save.to_io(io, pdf:)

      # Assert
      io.rewind

      File.open("test/support/fixture.pdf", "rb") do |fixture|
        assert(FileUtils.compare_stream(fixture, io), "PDF doesn't match the fixture")
      end
    end
  end
end
