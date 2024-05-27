# frozen_string_literal: true

describe YandexDisk::Request::Resources do
  subject(:resources) { described_class.new(YANDEX_DISK_TOKEN) }

  describe '#requst_info' do
    context 'when the full info requested' do
      let(:response) { VCR.use_cassette('resources/request_info_full') { resources.request_info(path: 'readme.pdf') } }
      let(:expected_keys) do
        %i[
          antivirus_status
          comment_ids created custom_properties
          exif
          file
          md5 media_type mime_type modified
          name
          path preview
          resource_id revision
          sha256 size sizes
          type
        ]
      end

      it('returns the correct class') { expect(response.class).to eq YandexDisk::Resources }
      it('returns the expected keys') { expect(response.to_h.keys.sort).to eq expected_keys }
    end

    context 'when certaiin fields requested' do
      let(:response) do
        VCR.use_cassette('resources/request_info_part') do
          resources.request_info(path: 'readme.pdf', fields: %i[name path])
        end
      end

      it('returns the expected data') { expect(response.to_h).to eq({ path: 'disk:/readme.pdf', name: 'readme.pdf' }) }
    end

    context 'when the required keys were not passed' do
      subject(:key_error) { resources.request_info }

      it('raises an exception') { expect { key_error }.to raise_error YandexDisk::Request::RequiredKeyError, /path/ }
    end
  end

  describe '#set_custom_properties' do
    context 'when passed all required keys and requested default fields' do
      let(:response) do
        VCR.use_cassette 'resources/set_custom_properties_full' do
          resources.set_custom_properties(path: 'readme.pdf', body: { foo: 'bar' })
        end
      end
      let(:expected_keys) do
        %i[
          antivirus_status
          comment_ids created custom_properties
          exif
          file
          md5 media_type mime_type modified
          name
          path preview
          resource_id revision
          sha256 size sizes
          type
        ]
      end

      it('returns the correct class') { expect(response.class).to eq YandexDisk::Resources }
      it('returns the expected keys') { expect(response.to_h.keys.sort).to eq expected_keys }
    end

    context 'when the body was not passed' do
      subject(:key_error_body) { resources.set_custom_properties(path: 'readme.pdf') }

      it('raises an exception') { expect { key_error_body }.to raise_error YandexDisk::Request::RequiredKeyError, /body/ }
    end

    context 'when the path was not passed' do
      subject(:key_error_path) { resources.set_custom_properties(body: { foo: 'bar' }) }

      it('raises an exception') { expect { key_error_path }.to raise_error YandexDisk::Request::RequiredKeyError, /path/ }
    end
  end
end
