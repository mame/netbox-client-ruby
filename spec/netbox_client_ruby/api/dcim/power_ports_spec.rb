require 'spec_helper'

describe NetboxClientRuby::DCIM::PowerPorts, faraday_stub: true do
  let(:expected_length) { 50 }
  let(:singular_type) { NetboxClientRuby::DCIM::PowerPort }

  let(:response) { File.read('spec/fixtures/dcim/power-ports.json') }
  let(:request_url) { '/api/dcim/power-ports.json' }
  let(:request_url_params) do
    { limit: NetboxClientRuby.config.netbox.pagination.default_limit }
  end

  context 'unpaged fetch' do
    describe '#length' do
      it 'shall be the expected length' do
        expect(subject.length).to be expected_length
      end
    end

    describe '#total' do
      it 'shall be the expected total' do
        expect(subject.total).to be expected_length
      end
    end
  end

  describe '#reload' do
    it 'fetches the correct data' do
      expect(faraday).to receive(:get).and_call_original
      subject.reload
    end

    it 'caches the data' do
      expect(faraday).to receive(:get).and_call_original
      subject.total
      subject.total
    end

    it 'reloads the data' do
      expect(faraday).to receive(:get).twice.and_call_original
      subject.reload
      subject.reload
    end
  end

  describe '#as_array' do
    it 'return the correct amount' do
      expect(subject.as_array.length).to be expected_length
    end

    it 'returns Site instances' do
      subject.as_array.each do |element|
        expect(element).to be_a singular_type
      end
    end
  end
end
