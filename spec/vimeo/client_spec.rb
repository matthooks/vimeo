require 'spec_helper'

describe Vimeo::Client do
  let(:client) { Vimeo::Client.new access_token: 'test' }

  describe '#access_token?' do
    subject { client.access_token? }
    context 'with access token given' do
      it { is_expected.to eq true }
    end

    context 'without access token given' do
      before { client.access_token = nil }
      it { is_expected.to eq false }
    end
  end

  describe '#initialize' do
    subject { client.access_token }
    it { is_expected.to eq 'test' }
  end

  describe '.new_oauth_request' do
    subject { Vimeo::Client.new_oauth_request 'client', 'secret', 'uniquekey', ['public', 'upload'] }
    it { is_expected.to be_kind_of OAuth2::Client }

    it 'sets the base oauth endpoint' do
      expect(subject.site).to eq 'https://api.vimeo.com'
    end

    it 'sets the scope param' do
      expect(subject.options[:connection_opts][:params][:scope]).to eq 'public upload'
    end

    it 'sets the state param' do
      expect(subject.options[:connection_opts][:params][:state]).to eq 'uniquekey'
    end
  end
end