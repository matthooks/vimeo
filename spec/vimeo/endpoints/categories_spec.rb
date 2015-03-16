require "spec_helper"

describe Vimeo::Endpoints::Categories do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  describe '.categories', :vcr do
    subject { client.categories }

    it { is_expected.to be_a_kind_of(Vimeo::Collection) }

    it 'has a collection of categories' do
      expect(subject.first).to be_a_kind_of(Vimeo::Entities::Category)
    end
  end

  describe '.category', :vcr do
    subject { client.category 1 }

    it { is_expected.to be_a_kind_of(Vimeo::Entities::Category) }
  end
end
