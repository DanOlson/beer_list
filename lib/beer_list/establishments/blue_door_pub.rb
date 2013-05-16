module BeerList
  module Establishments
    class BlueDoorPub < Establishment
      URL = 'http://thebdp.com/?page_id=159'

      def get_list
        page.search('div.two-columns li a').map(&:text)
      end

      def url
        URL
      end
    end
  end
end
