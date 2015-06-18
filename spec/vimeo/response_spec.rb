require 'spec_helper'

describe Vimeo::Response do
  let(:options) do; { body: '{"foo": "bar"}', headers: {}, status: 200 } end
  let(:response) { Vimeo::Response.new options  }

  describe "#parse_response_or_fail" do
    subject { response.parse_response_or_fail }

    it 'parses the response into a hash' do
      expect(subject[:foo]).to eq 'bar'
    end

    context 'when http 5xx' do
      before { options[:status] = 503 }
      it 'raises an exception' do
        expect { response.parse_response_or_fail }.to raise_exception Vimeo::Error::Unavaliable
      end
    end
  end

  describe '#parse' do
  end
end