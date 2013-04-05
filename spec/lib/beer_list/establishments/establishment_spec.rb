require 'spec_helper'

module BeerList
  module Establishments

    describe Establishment do
      let(:establishment){ BeerList::Establishments::Establishment.new }

      describe '#list' do
        it "raises an exception if it doesn't have a scraper" do
          expect { establishment.list }.to raise_error(NoScraperError)
        end
      end

      describe '#get_list' do
        it 'raises an exception unless it is implemented in a subclass' do
          expect { establishment.get_list }.to raise_error
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
