require "spec_helper"

describe Vimeo::Categories do

  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  describe '.me', :vcr do
    subject { client.me }
    it { is_expected.to be_a_kind_of(Vimeo::Entities::User) }
  end
end
