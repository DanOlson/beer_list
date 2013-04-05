require 'spec_helper'

module BeerList
  module Establishments

    describe Establishment do
      let(:establishment){ BeerList::Establishments::Establishment.new }

      describe '#list' do
        context "when it doesn't have a scraper" do
          it "raises an exception" do
            expect { establishment.list }.to raise_error(NoScraperError)
          end
        end

        context 'when it has a scraper' do

          before do
            establishment.scraper = stub
          end

          it 'returns a BeerList::List' do
            establishment.stub(:get_list){ [] }
            establishment.list.should be_an_instance_of BeerList::List
          end
        end
      end

      describe '#get_list' do
        context 'when it is not implemented in a subclass' do
          it 'raises an exception' do
            expect { establishment.get_list }.to raise_error
          end
        end
      end

      describe '#url' do
        it 'raises an exception unless it is implemented in a subclass' do
          expect { establishment.get_list }.to raise_error
        end
      end

      describe '#short_class_name' do
        let(:establishment){ BeerList::Establishments::MuddyWaters.new }

        it 'returns a usable name' do
          establishment.short_class_name.should == 'MuddyWaters'
        end
      end
    end
  end
end
