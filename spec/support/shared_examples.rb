shared_examples 'an endpoint' do |method, entity, collection, args|
  let(:client) { Vimeo::Client.new access_token: $vimeo_access_token }

  describe ".#{method}", :vcr do
    subject do
      call_args = args.nil? ? [method] : [method, args]
      client.public_send *call_args
    end

    if collection
      it { is_expected.to be_a_kind_of Vimeo::Collection } if collection

      it "has a collection of #{method}" do
        expect(subject.first).to be_a_kind_of entity
      end
    else
      it { is_expected.to be_a_kind_of entity }
    end
  end
end