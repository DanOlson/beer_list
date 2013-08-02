module BeerList
  module Establishments
    class ParkTavern < Establishment
      URL     = 'http://parktavern.net/drink/beer'
      ADDRESS = '3401 Louisiana Ave S St Louis Park, MN 55426'

      def get_list
        base_list
        reject_empty
        match_before_paren
        uniq
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def base_list
        @beers = page.search('p strong').map(&:text).map &:strip
      end

      def reject_empty
        @beers = @beers.select { |b| b.match /\w/ }
      end

      def match_before_paren
        @beers = @beers.map { |b| b.match(/\(/) ? $`.strip : b }
      end

      def uniq
        @beers = @beers.uniq
      end
    end
  end
end
