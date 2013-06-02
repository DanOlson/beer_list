module BeerList
  module Establishments
    class GingerHop < Establishment
      URL   = 'http://www.gingerhop.com/beer'
      ADDRESS = '201 E Hennepin Ave, Minneapolis, MN 55414'

      def get_list
        page.search('div.left-col h5').map(&:text)
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
