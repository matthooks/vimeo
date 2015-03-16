require "spec_helper"

describe Vimeo::Endpoints::Channels do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  describe '.channels', :vcr do
    subject { client.channels }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of categories' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Channel)
    end
  end

  describe '.channel', :vcr do
    subject { client.channel 1 }

    it { is_expected.to be_a_kind_of(Vimeo::Entities::Channel) }
  end
end
