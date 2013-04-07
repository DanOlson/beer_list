module BeerList
  module Establishments
    class BulldogLowertown < Establishment
      URL = 'http://www.thebulldoglowertown.com/beer/'

      def get_list
        page.search('ul.beerlist li').map(&:text)
      end

      def url
        URL
      end
    end
  end
end
