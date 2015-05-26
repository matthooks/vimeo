require 'spec_helper'

describe Vimeo::Entities::Channel do

  let(:channel_options) { { name: 'test channel', description: 'test description', privacy: 'anybody' } }
  let(:client) { Vimeo::Client.new access_token: $vimeo_access_token }
  let(:channel) { Vimeo::Entities::Channel.new client, id: 919982 }

  describe '#users', :vcr do
    subject { channel.users }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of users' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::User)
      expect(subject.first.name).to_not be_empty
    end
  end

  describe '#videos', :vcr do
    subject { channel.videos }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of videos' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Video)
    end
  end

  describe '#delete', :vcr do
    let(:channel) { Vimeo::Entities::Channel.create client, channel_options }
    subject { channel.delete }
    it { is_expected.to be true }
  end

  describe '#update', :vcr do
    let(:channel) { Vimeo::Entities::Channel.create client, channel_options }
    subject { channel.update name: 'test channel 123' }
    it { is_expected.to be true }
  end

  describe '.create', :vcr do
    subject { Vimeo::Entities::Channel.create client, channel_options }
    it { is_expected.to be true }
  end
end