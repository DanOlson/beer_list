require 'spec_helper'

module BeerList
  describe Scraper do
    let(:establishment){ BeerList::Establishments::Establishment.new }
    let(:scraper){ Scraper.instance }
    let(:agent){ stub }
    let(:url){ "http://omg.io" }

    before do
      scraper.stub(:agent){ agent }
      agent.stub(:user_agent_alias=)
    end

    describe '#send_json' do
      let(:json){ "{\"foo\":\"bar\"}" }
      let(:headers){ { 'Content-Type' => 'application/json' } }

      it 'posts to the given url with namespaced parameters' do
        expected_json = "{\"beer_list\": #{json}}"
        agent.should_receive(:post).with url, expected_json, headers
        scraper.send_json url, json
      end

      it 'prepends a scheme if one is not given' do
        expected_json = "{\"beer_list\": #{json}}"
        no_scheme_url = 'www.foobar.com'
        agent.should_receive(:post).with "http://#{no_scheme_url}", expected_json, headers
        scraper.send_json no_scheme_url, json
      end
    end

    describe '#beer_list' do
      before do
        scraper.should_receive(:visit).with establishment
      end

      it "calls the establishment's #list method" do
        establishment.should_receive :list
        scraper.beer_list establishment
      end
    end

    describe '#visit' do
      before do
        establishment.stub(:url){ url }
        establishment.stub(:list)
      end

      it "visits the establishment's url" do
        agent.should_receive(:get).with(url){ 'the page' }
        scraper.beer_list establishment
      end

      it "assigns to establishment.page" do
        agent.stub(:get){ 'the page' }
        establishment.should_receive(:page=).with 'the page'
        scraper.beer_list establishment
      end
    end
  end
end
