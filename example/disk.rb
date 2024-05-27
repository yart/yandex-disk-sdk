# frozen_string_literal: true

require_relative '../lib/yandex_disk'

# Set up YANDEX_DISK_TOKEN before

# disk = YandexDisk::Request::Disk.new ENV['YANDEX_DISK_TOKEN']
# pp disk.request_info %w[paid_max_file_size used_space system_folders]
#
# pp YandexDisk.disk_info 'used_space', token: ENV['YANDEX_DISK_TOKEN']
#
# pp YandexDisk.disk_info 'total_space'
#
# YandexDisk.token = ENV['YANDEX_DISK_TOKEN']
# pp YandexDisk.disk_info('user')

pp YandexDisk.disk_info.inspect
pp YandexDisk.disk_info
