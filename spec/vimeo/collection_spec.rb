require 'spec_helper'

describe Vimeo::Collection, :vcr do

  let(:client) { Vimeo::Client.new access_token: $vimeo_access_token }
  subject { client.channels }

  describe '#initialize' do
    it 'has an array of items' do
      expect(subject.items).to be_kind_of Array
    end
  end

  describe '#next_page' do
    before { subject.next_page }
    it 'goes to the next page' do
      expect(subject.current_page).to eq 2
    end
  end

  describe '#previous_page' do
    subject { client.channels page: 2 }
    it 'goes to the previous page' do
      subject.previous_page
      expect(subject.current_page).to eq 1
    end
  end

  describe '#first_page' do
    subject { client.channels page: 5 }
    it 'goes to the first page' do
      subject.first_page
      expect(subject.current_page).to eq 1
    end
  end

  describe '#last_page' do
    it 'goes to the last page' do
      subject.last_page
      expect(subject.current_page).to be > 1
    end
  end

  describe '#missing_method' do
    it 'delegates all missing methods to items' do
      expect(subject.items).to respond_to :first
    end
  end
end