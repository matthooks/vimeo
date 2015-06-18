require 'spec_helper'

describe Vimeo::Entities::Category do

  let(:client) { Vimeo::Client.new access_token: $vimeo_access_token }
  let(:category) { Vimeo::Entities::Category.new client, name: 'animation' }

  describe '#channel', :vcr do
    subject { category.channels }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of channels' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Channel)
    end
  end

  describe '#groups', :vcr do
    subject { category.groups }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of groups' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Group)
    end
  end

  describe '#videos', :vcr do
    subject { category.videos }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of videos' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Video)
    end
  end

  describe '#has_video?', :vcr do
    context 'it exists' do
      subject { category.has_video?(1084537) }
      it { is_expected.to be_a_kind_of Vimeo::Entities::Video }
    end

    context 'video exists' do
      subject { category.has_video(0) }
      it { is_expected.to be nil }
    end
  end
end