require "spec_helper"

describe Vimeo::Endpoints::Tags do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  describe '.tags', :vcr do
    subject { client.tags 'comedy' }

    it { is_expected.to be_a_kind_of(Vimeo::Entities::Tag) }
  end
end
