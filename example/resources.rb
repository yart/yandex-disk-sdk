# frozen_string_literal: true

require_relative '../lib/yandex_disk'

# Set up YANDEX_DISK_TOKEN before

# resourse = YandexDisk::Request::Resources.new(ENV['YANDEX_DISK_TOKEN'])
# pp resourse.request_info(path: '/111.test')

# pp YandexDisk.resourse_info(path: '111.test', token: ENV['YANDEX_DISK_TOKEN'])

# pp YandexDisk.download_resourse(path: '111.test')

pp YandexDisk.upload_resourse(path: 'README.md', overwrite: true)
