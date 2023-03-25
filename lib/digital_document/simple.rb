# frozen_string_literal: true

module DigitalDocument
  class Simple
    attr_reader :pages
    private attr_writer :pages

    def initialize
      self.pages = []
    end
  end
end
