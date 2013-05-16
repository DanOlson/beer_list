module BeerList
  module Establishments
    class LowryUptown < Establishment
      URL = 'http://www.thelowryuptown.com/drink'

      def get_list
        base_list
        match_before_abv
        strip
      end

      def url
        URL
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
