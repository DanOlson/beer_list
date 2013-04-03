module BeerList
  module Establishments
    class EdinaGrill < Establishment
      URL = 'http://www.edinagrill.com/beer_taps.php'

      def get_list
        @list = page.search('li span').map(&:text)
      end

      def url
        URL
      end
    end
  end
end
