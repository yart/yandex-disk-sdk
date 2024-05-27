# frozen_string_literal: true

module YandexDisk
  module Request
    class Error < ::StandardError
    end

    class WrongRequestMethod < Error
      def initialize(method) = super "Method `#{method}' is forbidden. Allowed methods are only #{ALLOWED_METHODS.join(', ')}"
    end

    class RequiredKeyError < Error
      def initialize(key) = super "Key `#{key}:' is required!"
    end

    class ResourseAlreadyExists < Error
      def initialize(path) = super "Resourse #{path} already exitst."
    end
  end
end
