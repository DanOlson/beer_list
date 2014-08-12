require 'spec_helper'

module BeerList
  describe List do
    let(:listable) do
      double('listable', name: 'Applebirds', address: '123 Fake St', url: 'example.com')
    end
    let(:list){ List.new array: ['item'], listable: listable }

    it 'knows its listable' do
      expect(list.listable).to eq listable
    end

    describe '#to_hash' do
      it 'hashes its listable info with its list' do
        expected = { name: 'Applebirds', address: '123 Fake St', url: 'example.com', list: ['item']}
        expect(list.to_hash).to eq expected
      end
    end

    describe '#to_json' do
      it 'returns the list as json' do
        expected = %({"name":"Applebirds","address":"123 Fake St","url":"example.com","list":["item"]})
        expect(list.to_json).to eq expected
      end
    end

    context 'when array is nil (the establishment has yet to implement #get_list)' do
      let(:list){ List.new array: nil, listable: listable }

      it { expect(list).to be_empty }
    end
  end
end
