require 'spec_helper'

describe BeerList do
  let(:establishment){ BeerList::Establishments::ThreeSquares.new }

  describe '.establishments' do
    it 'returns an array' do
      BeerList.establishments.should be_an_instance_of Array
    end

    it 'stores establishments' do
      BeerList.establishments << establishment
      BeerList.establishments.should_not be_empty
    end
  end

  describe '.lists' do
    context 'when no establishments are registered' do
      it 'should raise an error' do
        BeerList.establishments.clear
        expect { BeerList.lists }.to raise_error(BeerList::NoEstablishmentsError)
      end
    end

    context 'when establishments are registered' do
      before(:all) do
        BeerList.establishments << establishment
      end

      after(:all) do
        BeerList.establishments.clear
      end

      before do
        establishment.stub(:get_list){ ['Darkness', 'Pliney the Elder'] }
      end

      it 'returns an array of lists' do
        BeerList.lists.all?{ |l| l.is_a? BeerList::List }.should be_true
      end

      it 'contains lists for the registered establishments' do
        BeerList.lists.first.establishment.should == 'ThreeSquares'
      end

      describe '.lists_as_hash' do
        it 'returns a hash' do
          BeerList.lists_as_hash.should be_an_instance_of Hash
        end
      end

      describe '.lists_as_json' do
        it 'returns JSON' do
          expect { JSON.parse(BeerList.lists_as_json) }.to_not raise_error
        end
      end
    end
  end

end
