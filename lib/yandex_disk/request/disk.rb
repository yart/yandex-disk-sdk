# frozen_string_literal: true

module YandexDisk
  module Request
    # General information about the user's Yandex Disk: the available space, system folder paths, and so on.
    class Disk < Base
      # @param [Array<String>] fields
      # @return [YandexDisk::Disk] response
      def request_info(*fields)
        request(:get, path: '/disk', query: { fields: })
      end
    end
  end
end
