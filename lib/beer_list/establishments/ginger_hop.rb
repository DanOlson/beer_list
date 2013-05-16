module BeerList
  module Establishments
    class GingerHop < Establishment
      URL = 'http://www.gingerhop.com/beer'

      def get_list
        page.search('div.left-col h5').map(&:text)
      end

      def url
        URL
      end
    end
  end
end
