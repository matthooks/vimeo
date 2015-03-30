require 'spec_helper'

describe Vimeo::Entities::Channel do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  let(:channel) { Vimeo::Entities::Channel.new client, id: 898459 }

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

  describe '.create' do
    let(:options) { { name: 'test', description: 'test', privacy: 'users'} }
    subject { Vimeo::Entities::Channel.create client, options }

    it { is_expected.to be_a_kind_of described_class }
  end

  describe '#delete' do
    subject { channel.delete }
    it { is_expected.to be true }
  end
end