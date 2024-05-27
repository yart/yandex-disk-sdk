# frozen_string_literal: true

require 'httparty'
require 'active_support'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/string'

require_relative 'yandex_disk/request'

module YandexDisk
  class << self
    include Helper

    attr_writer :token

    # @param [Array<String>] fields
    # @param [Hash] opts
    # @option opts [String] token
    # @return [HTTParty::Response]
    def disk_info(*fields, **opts)              = Request::Disk.new(fetch_token(**opts)).request_info(*fields)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @option query [Boolean] force_async
    # @option query [String] md5
    # @option query [Boolean] permanently
    # @return [HTTParty::Response]
    def remove_resourse(**query)                = resourse_object(**query).remove(**query)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @option query [Bignum] limit
    # @option query [Bignum] offset
    # @option query [Boolean] preview_crop
    # @option query [String] preview_size
    # @option query [String] sort
    # @return [HTTParty::Response]
    def resourse_info(**query)                  = resourse_object(**query).request_info(**query)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @option query [Hash] body required
    # @return [HTTParty::Response]
    def set_resourse_custom_properties(**query) = resourse_object(**query).set_custom_properties(**query)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @return [HTTParty::Response]
    def make_directory(**query)                 = resourse_object(**query).make_directory(**query)

    # @param [Hash] query
    # @option query [String] from required
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @option query [Boolean] force_async
    # @option query [Boolean] overwrite
    # @return [HTTParty::Response]
    def copy_resourse(**query)                  = resourse_object(**query).copy(**query)

    # @param [Hash] query
    # @option query [String] from required
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @option query [Boolean] force_async
    # @option query [Boolean] overwrite
    # @return [HTTParty::Response]
    def move_resourse(**query)                  = resourse_object(**query).move(**query)

    # @param [Hash] query
    # @option query [Array<String>] fields
    # @option query [Bignum] limit
    # @option query [Bignum] offset
    # @option query [String] media_type
    # @option query [Boolean] preview_crop
    # @option query [String] preview_size
    # @option query [String] sort
    # @return [HTTParty::Response]
    def files_list(**query)                     = resourse_object(**query).files_list(**query)

    # @param [Hash] query
    # @option query [Array<String>] fields
    # @option query [Bignum] limit
    # @option query [String] media_type
    # @option query [Boolean] preview_crop
    # @option query [String] preview_size
    # @option query [String] sort
    # @return [HTTParty::Response]
    def last_uploaded_list(**query)             = resourse_object(**query).last_uploaded_list(**query)

    # @param [Hash] query
    # @option query [Array<String>] fields
    # @option query [Bignum] limit
    # @option query [String] media_type
    # @option query [Boolean] preview_crop
    # @option query [String] preview_size
    # @option query [String] sort
    # @return [HTTParty::Response]
    def public_files_list(**query)              = resourse_object(**query).public_files_list(**query)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @return [HTTParty::Response]
    def publish(**query)                        = resourse_object(**query).publish(**query)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @return [HTTParty::Response]
    def unpublish(**query)                      = resourse_object(**query).unpublish(**query)

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @return [HTTParty::Response]
    def download_resourse(**query)
      link = resourse_object(**query).get_download_link(**query)['href']

      File.open(query[:path], 'w') do |file|
        file.binmode
        HTTParty.get(link, stream_body: true) do |fragment|
          file.write(fragment)
        end
      end
    end

    # @param [Hash] query
    # @option query [String] path required
    # @option query [Array<String>] fields
    # @option query [Boolean] overwrite
    # @return [HTTParty::Response]
    def upload_resourse(**query)
      body_stream = File.open(query[:path], 'r')
      headers     = { 'Content-Length' => body_stream.size.to_s, 'Transfer-Encoding' => 'chunked' }
      response    = resourse_object(**query).get_upload_link(**query)

      raise Request::ResourseAlreadyExists, query[:path] if response.code == 409

      link = response['href']
      HTTParty.put(link, body_stream:, headers:)
    end

    private

    def fetch_token(**opts) = opts[:token] || @token || env_token
    def resourse_object(**) = Request::Resources.new(fetch_token(**))
  end
end
