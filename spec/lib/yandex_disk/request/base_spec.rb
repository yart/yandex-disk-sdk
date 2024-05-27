# frozen_string_literal: true

describe YandexDisk::Request::Base do
  let(:token) { ENV['YANDEX_DISK_TOKEN'] }

  subject { described_class.new(token) }

  describe '#request' do
    it 'raises exception when incorrect HTTP method called' do
      expect { subject.send(:request, :head, path: '/path') }.to raise_error YandexDisk::Request::WrongRequestMethod
    end
  end
end
