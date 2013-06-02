module BeerList
  module Establishments
    class ThreeSquares < Establishment
      URL     = 'http://www.3squaresrestaurant.com/beer_taps.php'
      ADDRESS = '12690 Arbor Lakes Pkwy N, Maple Grove, Minnesota 55369'

      def get_list
        page.at('ul').text.split("\r\n")
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
