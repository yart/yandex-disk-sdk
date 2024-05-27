# frozen_string_literal: true

module YandexDisk
  module Helper
    require 'active_support/core_ext'

    private

    EXCLUDED_CLASSES = [TrueClass, FalseClass, NilClass, Symbol].freeze

    def env_token
      ENV['YANDEX_DISK_TOKEN']
    end

    def query(params = {})
      given_params = params.deep_dup

      fields_key = fields(given_params.delete(:fields))
      other_keys = given_params.map { |k, v| "#{k}=#{EXCLUDED_CLASSES.include?(v.class) ? v : URI.parse(CGI.escape(v))}" }.join('&')

      "?#{[fields_key, other_keys].compact.join('&')}"
    end

    def fields(*list)
      fields_list = list.compact.empty? ? nil : list.join(',')
      fields_list = "fields=#{fields_list}" unless fields_list.nil?
      fields_list
    end
  end
end
