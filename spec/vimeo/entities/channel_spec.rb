require 'spec_helper'

describe Vimeo::Entities::Channel do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  let(:channel) { Vimeo::Entities::Channel.new client, id: 873758 }

  describe '#users', :vcr do
    subject { channel.users }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of users' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::User)
    end
  end

  describe '#videos', :vcr do
    subject { channel.videos }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of videos' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Video)
    end
  end
end