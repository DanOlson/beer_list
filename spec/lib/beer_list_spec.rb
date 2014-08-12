require 'spec_helper'

module BeerList
  module Establishments
    class MuddyWaters < Establishment; end
    class ThreeSquares < Establishment; end
  end
end

describe BeerList do
  let(:establishment){ BeerList::Establishments::ThreeSquares.new }
  let(:scraper){ double 'scraper' }

  describe '.configure' do
    before do
      BeerList.configure do |c|
        c.establishments_dir = '/home/foo'
        c.default_url        = 'http://omg.io'
      end
    end

    it 'stores the establishments_dir' do
      expect(BeerList.establishments_dir).to eq '/home/foo'
    end

    it 'stores the default_url' do
      expect(BeerList.default_url).to eq 'http://omg.io'
    end
  end

  describe '.establishments' do
    it 'returns an array' do
      expect(BeerList.establishments).to be_an_instance_of Array
    end
  end

  describe '.add_establishment' do
    let(:muddy_waters){ BeerList::Establishments::MuddyWaters.new }

    after(:each) do
      BeerList.clear_establishments!
    end

    it 'appends to establishments' do
      BeerList.add_establishment establishment
      expect(BeerList.establishments).to include establishment
    end

    it 'accepts multiple establishments' do
      BeerList.add_establishment establishment, muddy_waters
      expect(BeerList.establishments.size).to eq 2
    end

    it 'rejects invalid input' do
      BeerList.add_establishment muddy_waters, Object.new
      expect(BeerList.establishments.size).to eq 1
    end

    it 'can be called multiple times' do
      BeerList.add_establishment muddy_waters
      BeerList.add_establishment establishment
      expect(BeerList.establishments.size).to eq 2
    end
  end

  describe '.clear_establishments!' do

    shared_examples_for 'clear_establishments!' do
      it 'should empty the collection' do
        BeerList.clear_establishments!
        expect(BeerList.establishments).to be_empty
      end
    end

    context 'when establishments are registered' do
      before do
        BeerList.add_establishment establishment
      end

      it_behaves_like 'clear_establishments!'
    end

    context 'when no establishments are registered' do
      it_behaves_like 'clear_establishments!'
    end
  end

  describe '.lists' do
    context 'when no establishments are registered' do
      it 'should raise an error' do
        BeerList.clear_establishments!
        expect { BeerList.lists }.to raise_error(BeerList::NoEstablishmentsError)
      end
    end

    context 'when establishments are registered' do
      let(:list){ BeerList::List.new listable: establishment, array: [] }

      before do
        allow(BeerList).to receive(:establishments){ [establishment] }
        allow(BeerList).to receive(:update_necessary?){ true }
        allow(BeerList).to receive(:scraper){ scraper }
        expect(scraper).to receive(:beer_list).with(establishment){ list }
      end

      it 'returns an array of lists' do
        expect(BeerList.lists.all?{ |l| l.is_a? BeerList::List }).to eq true
      end

      it 'contains lists for the registered establishments' do
        listable = BeerList.lists.first.listable
        expect(listable).to eq establishment
      end

      describe '.lists_as_hash' do
        it 'returns an array of hashes' do
          expect(BeerList.lists_as_hash.all? { |l| l.is_a? Hash }).to eq true
        end
      end

      describe '.lists_as_json' do
        it 'returns an array of valid JSON' do
          expect { BeerList.lists_as_json.each { |j| JSON.parse(j) } }.to_not raise_error
        end
      end
    end
  end

  describe 'sending lists' do
    let(:url){ 'http://omg.io' }
    let(:json){ "{\"foo\":\"bar\"}" }
    let(:list){ BeerList::List.new }
    let(:expected){ [url, [json]] }

    before do
      allow(BeerList).to receive(:scraper){ scraper }
      allow(list).to receive(:to_json){ json }
    end

    describe '.send_list' do
      it 'delegates to the scraper' do
        expect(scraper).to receive(:send_json).with *expected
        BeerList.send_list list, url
      end
    end

    describe '.send_lists' do
      before do
        allow(BeerList).to receive(:lists){ [list] }
        allow(list).to receive(:to_hash){ { foo: 'bar' } }
      end

      it 'delegates to the scraper' do
        expect(scraper).to receive(:send_json).with *expected
        BeerList.send_lists url
      end
    end
  end
end
