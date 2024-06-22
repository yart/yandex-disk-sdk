# frozen_string_literal: true

module YandexDisk
  module Request
    ALLOWED_METHODS = %w[delete get patch post put].freeze

    # General information about the user's Yandex Disk: the available space, system folder paths, and so on.
    class Base
      include HTTParty
      include YandexDisk::Helper

      base_uri 'https://cloud-api.yandex.net/v1'

      # @param [String] token
      def initialize(token) = @auth = { Authorization: "OAuth #{token}" }

      private

      # @param [Symbol, String] method
      # @param [String] path
      # @param [Hash] query
      # @param [Hash] options
      # @return [YandexDisk::Disk, YandexDisk:::Resources] response
      def request(method, path:, query: {}, options: {})
        raise Request::WrongRequestMethod, method unless ALLOWED_METHODS.include?(method.to_s)

        # Getting a response class object
        object  = Object.const_get("YandexDisk::#{self.class.to_s.split('::').last}")
        headers = @auth.merge(Accept: 'application/json')

        object.new(self.class.send(method, "#{path}#{query(query)}", { headers: }.merge(options)))
      end
    end
  end
end
