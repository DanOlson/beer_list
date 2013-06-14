module BeerList
  module Establishments
    class McCoysMN < Establishment
      attr_accessor :url

      ADDRESS = '3801 Grand Way, St Louis Park, MN 55416'
      DRAFTS  = 'http://mccoysmn.com/beer/'
      BOTTLES = 'http://mccoysmn.com/beer/bottles'

      def initialize
        @url = DRAFTS
      end

      def get_list
        @beers = []
        get_draft_list
        get_bottle_list
      end

      def address
        ADDRESS
      end

      private

      def get_draft_list
        @beers += base_list
      end

      def get_bottle_list
        self.url  = BOTTLES
        self.page = BeerList.scraper.visit self
        @beers   += base_list
      end

      def base_list
        page.search('td.title a').map(&:text)
      end
    end
  end
end
