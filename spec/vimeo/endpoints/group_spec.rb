require "spec_helper"

describe Vimeo::Endpoints::Groups do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  describe '.groups', :vcr do
    subject { client.groups }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of groups' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Group)
    end
  end

  describe '.group', :vcr do
    subject { client.group 1 }

    it { is_expected.to be_a_kind_of(Vimeo::Entities::Group) }
  end
end
