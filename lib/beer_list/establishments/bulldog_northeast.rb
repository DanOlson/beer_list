module BeerList
  module Establishments
    class BulldogNortheast < Establishment
      URL = 'http://www.thebulldognortheast.com/beer/'

      def get_list
        list = page.search('p.copy_menu_item_desc').map(&:text)
        list.shift 2 # shift off Rotating Cask and Beer Flights
        list
      end

      def url
        URL
      end
    end
  end
end
