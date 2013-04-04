module BeerList
  module Establishments
    class ThreeSquares < Establishment
      URL = 'http://www.3squaresrestaurant.com/beer_taps.php'

      def get_list
        page.at('ul').text.split("\r\n")
      end

      def url
        URL
      end
    end
  end
end
