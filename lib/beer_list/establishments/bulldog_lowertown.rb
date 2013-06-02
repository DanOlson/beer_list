module BeerList
  module Establishments
    class BulldogLowertown < Establishment
      URL     = 'http://www.thebulldoglowertown.com/beer/'
      ADDRESS = '237 E 6th St, St Paul, MN 55101'

      def get_list
        page.search('ul.beerlist li').map(&:text)
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
