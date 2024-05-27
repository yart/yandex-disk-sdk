# frozen_string_literal: true

describe YandexDisk::Request::Disk do
  subject { described_class.new(YANDEX_DISK_TOKEN) }

  describe '#requst_info' do
    context 'when the full info requested' do
      let(:response) { VCR.use_cassette('disk/request_info_full') { subject.request_info } }
      let(:expected_keys) do
        %i[
          is_paid
          max_file_size
          paid_max_file_size
          reg_time
          revision
          system_folders
          total_space
          trash_size
          unlimited_autoupload_enabled
          used_space
          user
        ]
      end

      it('returns the correct class') { expect(response.class).to eq YandexDisk::Disk }
      it('returns the expected keys') { expect(response.to_h.keys.sort).to eq expected_keys }
    end

    context 'when certain fields requested' do
      let(:response) { VCR.use_cassette('disk/request_info_user') { subject.request_info(:user) } }

      it('returns the expected data') { expect(response.user).not_to be_nil }
    end
  end
end
