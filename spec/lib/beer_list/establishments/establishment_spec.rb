require 'spec_helper'

module BeerList
  module Establishments

    describe Establishment do
      let(:establishment){ BeerList::Establishments::Establishment.new }

      describe '#list' do
        it 'returns a BeerList::List' do
          establishment.stub(:visit_page)
          establishment.stub(:get_list){ [] }
          establishment.list.should be_an_instance_of BeerList::List
        end
      end

      describe '#get_list' do
        context 'when it is not implemented in a subclass' do
          it 'returns nil' do
            establishment.get_list.should be_nil
          end
        end
      end

      describe '#url' do
        context 'when it is not implemented in a subclass' do
          it 'returns nil' do
            establishment.url.should be_nil
          end
        end
      end

      describe '#address' do
        context 'when it is not implemented in a subclass' do
          it 'returns nil' do
            establishment.address.should be_nil
          end
        end
      end

      describe '#name' do
        it 'returns a usable name' do
          establishment.name.should == 'Establishment'
        end
      end
    end
  end
end
