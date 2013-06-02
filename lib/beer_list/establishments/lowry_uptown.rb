module BeerList
  module Establishments
    class LowryUptown < Establishment
      URL     = 'http://www.thelowryuptown.com/drink'
      ADDRESS = '2112 Hennepin Ave, Minneapolis, MN 55405'

      def get_list
        base_list
        match_before_abv
        strip
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def base_list
        @beers = page.search('div.third_col').first.search('p').map(&:text)
      end

      def match_before_abv
        @beers = @beers.map{ |beer| beer.match(/\d+\.?\d*%/); $` }.compact
      end

      def strip
        @beers = @beers.map{ |beer| beer.gsub(/\A\W*|\W*\z/, '') }
      end
    end
  end
end
