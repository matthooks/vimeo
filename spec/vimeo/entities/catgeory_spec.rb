require 'spec_helper'

describe Vimeo::Entities::Category do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

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

  describe '#users', :vcr do
    subject { category.users }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of users' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::User)
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
    context 'video exists' do
      it 'is true' do
        expect(category.video_exists?(1084537)).to eq true # Video is Big Buck Bunny
      end
    end

    context 'video doesn\'t exist' do
      it 'is false' do
        expect(category.video_exists?(0)).to eq false
      end
    end
  end
end