require 'spec_helper'

describe Vimeo::Entities::Category do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  let(:user) { Vimeo::Entities::User.new client, id: 152184 }

  describe '#appearences', :vcr do
    subject { user.appearences }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of channels' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Video)
    end
  end
end