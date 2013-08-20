require 'spec_helper'

module BeerList
  describe List do
    let(:listable){ double('listable', name: 'Applebirds', address: '123 Fake St', url: 'example.com') }
    let(:list){ List.new array: ['item'], listable: listable }

    it 'knows its listable' do
      list.listable.should == listable
    end

    describe '#to_hash' do
      it 'hashes its listable info with its list' do
        expected = { name: 'Applebirds', address: '123 Fake St', url: 'example.com', list: ['item']}
        list.to_hash.should == expected
      end
    end

    describe '#to_json' do
      it 'returns the list as json' do
        expected = %({"name":"Applebirds","address":"123 Fake St","url":"example.com","list":["item"]})
        list.to_json.should == expected
      end
    end

    context 'when array is nil (the establishment has yet to implement #get_list)' do
      let(:list){ List.new array: nil, listable: listable }

      it { list.should be_empty }
    end
  end
end
