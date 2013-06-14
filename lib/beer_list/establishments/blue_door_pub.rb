module BeerList
  module Establishments
    class BlueDoorPub < Establishment
      URL     = 'http://thebdp.com/?page_id=159'
      ADDRESS = '1811 Selby Ave, St Paul, MN 55104'

      def get_list
        page.search('div.two-columns li a').map(&:text)
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
