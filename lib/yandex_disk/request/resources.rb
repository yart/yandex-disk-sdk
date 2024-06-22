# frozen_string_literal: true

module YandexDisk
  module Request
    # General information about the user's Yandex Disk: the available space, system folder paths, and so on.
    class Resources < Base
      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @option query [Boolean] force_async
      # @option query [String] md5
      # @option query [Boolean] permanently
      # @return [YandexDisk::Resources]
      def remove(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:delete, path:, query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @option query [Bignum] limit
      # @option query [Bignum] offset
      # @option query [Boolean] preview_crop
      # @option query [String] preview_size
      # @option query [String] sort
      # @return [YandexDisk::Resources]
      def request_info(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:get, path:, query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @option query [Hash] body required
      # @return [YandexDisk::Resources]
      def set_custom_properties(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?
        raise Request::RequiredKeyError, :body if query[:body].nil?

        options = { custom_properties: query[:body] }

        request(:patch, path:, query: { path: query[:path], fields: query[:fields] }, options:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @return [YandexDisk::Resources]
      def make_directory(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:put, path:, query:)
      end

      # @param [Hash] query
      # @option query [String] from required
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @option query [Boolean] force_async
      # @option query [Boolean] overwrite
      # @return [YandexDisk::Resources]
      def copy(**query)
        raise Request::RequiredKeyError, :from if query[:from].nil?
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:post, path: "#{path}/copy", query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @return [YandexDisk::Resources]
      def get_download_link(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:get, path: "#{path}/download", query:)
      end

      # @param [Hash] query
      # @option query [Array<String>] fields
      # @option query [Bignum] limit
      # @option query [Bignum] offset
      # @option query [String] media_type
      # @option query [Boolean] preview_crop
      # @option query [String] preview_size
      # @option query [String] sort
      # @return [YandexDisk::Resources]
      def files_list(**query)
        request(:get, path: "#{path}/files", query:)
      end

      # @param [Hash] query
      # @option query [Array<String>] fields
      # @option query [Bignum] limit
      # @option query [String] media_type
      # @option query [Boolean] preview_crop
      # @option query [String] preview_size
      # @option query [String] sort
      # @return [YandexDisk::Resources]
      def last_uploaded_list(**query)
        request(:get, path: "#{path}/last_uploaded", query:)
      end

      # @param [Hash] query
      # @option query [String] from required
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @option query [Boolean] force_async
      # @option query [Boolean] overwrite
      # @return [YandexDisk::Resources]
      def move(**query)
        raise Request::RequiredKeyError, :from if query[:from].nil?
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:post, path: "#{path}/query", query:)
      end

      # @param [Hash] query
      # @option query [Array<String>] fields
      # @option query [Bignum] limit
      # @option query [String] media_type
      # @option query [Boolean] preview_crop
      # @option query [String] preview_size
      # @option query [String] sort
      # @return [YandexDisk::Resources]
      def public_files_list(**query)
        request(:get, path: "#{path}/public", query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @return [YandexDisk::Resources]
      def publish(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:put, path: "#{path}/publish", query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @return [YandexDisk::Resources]
      def unpublish(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:put, path: "#{path}/unpublish", query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [Array<String>] fields
      # @option query [Boolean] overwrite
      # @return [YandexDisk::Resources]
      def get_upload_link(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?

        request(:get, path: "#{path}/upload", query:)
      end

      # @param [Hash] query
      # @option query [String] path required
      # @option query [String] url required
      # @option query [Boolean] disable_redirects
      # @option query [Array<String>] fields
      # @return [YandexDisk::Resources]
      def upload_from_internet(**query)
        raise Request::RequiredKeyError, :path if query[:path].nil?
        raise Request::RequiredKeyError, :url if query[:url].nil?

        request(:post, path: "#{path}/upload", query:)
      end

      private

      def path = '/disk/resources'
    end
  end
end
