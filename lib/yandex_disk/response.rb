# frozen_string_literal: true

require 'ostruct'

module YandexDisk
  class Response < OpenStruct
    attr_reader :body, :code, :headers, :request, :response

    def initialize(response)
      @response = response

      @request = @response.request
      @code    = @response.code
      @headers = @response.headers
      @body    = @response.body

      super to_ostruct(@response.parsed_response)
    end

    def failed?    = code >= 400
    def successed? = !failed?

    def nil?               = @response.body.nil? || @response.body.empty?
    def to_s               = @response.to_s
    def pretty_print(pp)   = @response.pretty_print(pp)
    def display(port = $>) = @response.display(port)

    private

    def to_ostruct(obj)
      case obj
      when Hash
        # rubocop:disable Style/HashTransformValues
        OpenStruct.new(obj.map { |key, val| [key, to_ostruct(val)] }.to_h)
        # rubocop:enable Style/HashTransformValues
      when Array
        obj.map { |o| to_ostruct(o) }
      else
        obj
      end
    end
  end
end

require_relative 'response/disk'
require_relative 'response/error'
require_relative 'response/resources'