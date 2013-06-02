module BeerList
  module Establishments
    class EdinaGrill < Establishment
      URL     = 'http://www.edinagrill.com/beer_taps.php'
      ADDRESS = '5028 France Ave S, Edina, MN 55424'

      def get_list
        page.search('li span').map(&:text)
      end

      def url
        URL
      end

      def address
        ADDRESS
      end
    end
  end
end
