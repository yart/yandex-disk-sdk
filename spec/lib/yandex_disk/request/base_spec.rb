# frozen_string_literal: true

describe YandexDisk::Request::Base do
  subject(:base_instance) { described_class.new(ENV['YANDEX_DISK_TOKEN']) }

  let(:wrong_method) { :head }

  describe '#request' do
    it 'raises exception when incorrect HTTP method called' do
      expect { base_instance.send(:request, wrong_method, path: '/path') }.to raise_error YandexDisk::Request::WrongRequestMethod
    end
  end
end
