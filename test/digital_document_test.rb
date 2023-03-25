# frozen_string_literal: true

require "test_helper"

class TestDigitalDocument < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DigitalDocument::VERSION
  end
end
