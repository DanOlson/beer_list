require 'spec_helper'

module BeerList
  module Establishments

    describe Establishment do
      let(:establishment){ BeerList::Establishments::Establishment.new }

      describe '#list' do
        it 'returns a BeerList::List' do
          allow(establishment).to receive(:visit_page)
          allow(establishment).to receive(:get_list){ [] }
          expect(establishment.list).to be_an_instance_of BeerList::List
        end
      end

      describe '#get_list' do
        context 'when it is not implemented in a subclass' do
          it 'returns nil' do
            expect(establishment.get_list).to be_nil
          end
        end
      end

      describe '#url' do
        context 'when it is not implemented in a subclass' do
          it 'returns nil' do
            expect(establishment.url).to be_nil
          end
        end
      end

      describe '#address' do
        context 'when it is not implemented in a subclass' do
          it 'returns nil' do
            expect(establishment.address).to be_nil
          end
        end
      end

      describe '#name' do
        it 'returns a usable name' do
          expect(establishment.name).to eq 'Establishment'
        end
      end
    end
  end
end
