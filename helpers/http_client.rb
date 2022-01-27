# frozen_string_literal: true

require 'faraday'

module Helpers
  class HttpClient
    attr_accessor :connection

    def initialize(url)
      @connection = initialize_connection(url)
    end

    def get(route)
      @connection.get(route)
    end

    private

    def initialize_connection(url)
      Faraday.new(uri: url) { |faraday| faraday.adapter Faraday.default_adapter }
    end
  end
end