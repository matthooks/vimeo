require 'spec_helper'

describe Vimeo::Headers do
  let(:client) do
    Vimeo::Client.new {|c| c.access_token = 'hgf' }
  end

  describe '#request_headers' do
    subject { Vimeo::Headers.new(client).request_headers }
    it { is_expected.to have_key :user_agent }
    it { is_expected.to have_key :authorization }
  end
end