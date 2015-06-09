require 'spec_helper'

describe Vimeo::Headers do
  let(:client) do
    Vimeo::Client.new {|c| c.access_token = $vimeo_access_token }
  end

  describe '#request_headers' do
    subject { Vimeo::Headers.new(client).request_headers }

    it { is_expected.to have_key :user_agent }
    it { is_expected.to have_key :authorization }

    it 'has a bearer authentication token' do
      expect(subject[:authorization]).to match /bearer \w*/
    end
  end
end