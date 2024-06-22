# frozen_string_literal: true

module YandexDisk
  module Request
    class Error < ::StandardError
    end

    # Wehn a unsupported method sent
    class WrongRequestMethod < Error
      def initialize(method) = super "Method `#{method}' is forbidden. Allowed methods are only #{ALLOWED_METHODS.join(', ')}"
    end

    # When a required key wasn't passed
    class RequiredKeyError < Error
      def initialize(key) = super "Key `#{key}:' is required!"
    end

    # When such a resource is already exists on the Yandex.Disk
    class ResourseAlreadyExists < Error
      def initialize(path) = super "Resourse #{path} already exitst."
    end
  end
end
