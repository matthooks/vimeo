require 'spec_helper'

describe Vimeo::Request do
  let(:client)   { Vimeo::Client.new access_token: $vimeo_access_token }
  let(:options)  do; { client: client, method: :get, path: '/nopath', params: {}, body: nil } end
  let(:request)  { Vimeo::Request.new *options.values }

  describe '#initialize' do
    subject { request }

    it 'returns a Faraday instance' do
      expect(subject.performer).to be_kind_of Faraday::Connection
    end

    it 'sets the base vimeo endpoint to faraday' do
      expect(subject.performer.url_prefix.to_s).to eq 'https://api.vimeo.com/'
    end

    context 'without access token' do
      before { client.access_token = nil }

      it 'raises an exception' do
        expect { request }.to raise_exception Vimeo::Error::AccessTokenNotSet
      end
    end
  end

  describe '#perform', :vcr do
    subject { request.perform }

    context 'a succesfull request' do
      before { options[:path] = '/categories' }
      it { is_expected.to be_kind_of Hash }
    end

    context 'a unsuccesfull request' do
      it { is_expected.to eq false }
    end
  end

  describe '#perform!' do
    it 'raises an exception' do
      expect { request.perform! }.to raise_exception Vimeo::Error::NotFound
    end
  end
end