module BeerList
  module Establishments
    class StanleysBarRoom < Establishment
      URL = 'http://www.stanleysbarroom.com/drinks/beer-list/'

      def get_list
        base_list
        remove_blank
      end

      def url
        URL
      end

      private

      def base_list
        @beers = page.search('td ul li').map(&:text)
      end

      def remove_blank
        @beers = @beers.map(&:strip).reject{ |beer| beer.empty? }
      end
    end
  end
end
