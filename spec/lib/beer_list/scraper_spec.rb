require 'spec_helper'

module BeerList
  describe Scraper do
    let(:establishment){ BeerList::Establishments::Establishment.new }
    let(:scraper){ Scraper.instance }
    let(:agent){ double 'agent' }
    let(:url){ "http://omg.io" }

    before do
      allow(scraper).to receive(:agent){ agent }
      allow(agent).to receive(:user_agent_alias=)
    end

    describe '#send_json' do
      let(:json){ "{\"foo\":\"bar\"}" }
      let(:headers){ { 'Content-Type' => 'application/json' } }

      it 'posts to the given url with namespaced parameters' do
        expected_json = "{\"beer_list\": #{json}}"
        expect(agent).to receive(:post).with url, expected_json, headers
        scraper.send_json url, json
      end

      it 'prepends a scheme if one is not given' do
        expected_json = "{\"beer_list\": #{json}}"
        no_scheme_url = 'www.foobar.com'
        expect(agent).to receive(:post).with "http://#{no_scheme_url}", expected_json, headers
        scraper.send_json no_scheme_url, json
      end
    end

    describe '#beer_list' do
      before do
        expect(scraper).to receive(:visit).with establishment
      end

      it "calls the establishment's #list method" do
        expect(establishment).to receive :list
        scraper.beer_list establishment
      end
    end

    describe '#visit' do
      before do
        allow(establishment).to receive(:url){ url }
        allow(establishment).to receive(:list)
      end

      it "visits the establishment's url" do
        expect(agent).to receive(:get).with(url){ 'the page' }
        scraper.beer_list establishment
      end

      it "assigns to establishment.page" do
        allow(agent).to receive(:get){ 'the page' }
        expect(establishment).to receive(:page=).with 'the page'
        scraper.beer_list establishment
      end
    end
  end
end
