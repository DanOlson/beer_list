require 'spec_helper'

module BeerList
  describe List do
    let(:est_name){ 'MuddyWaters' }
    let(:list){ List.new array: [], establishment: est_name }

    it 'knows its establishent' do
      list.establishment.should == est_name
    end

    describe '#to_hash' do
      it 'hashes its establishment name with its content' do
        expected = { est_name => [] }
        list.to_hash.should == expected
      end
    end

    describe '#to_json' do
      it 'returns the list as json' do
        expected = "{\"MuddyWaters\":[]}"
        list.to_json.should == expected
      end
    end

    context 'when array is nil (the establishment has yet to implement #get_list)' do
      let(:list){ List.new array: nil, establishment: est_name }

      it { list.should be_empty }
    end
  end
end
