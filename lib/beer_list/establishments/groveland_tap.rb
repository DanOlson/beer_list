module BeerList
  module Establishments
    class GrovelandTap < Establishment
      URL   = 'http://www.grovelandtap.com/beer_taps.php'
      ADDRESS = '1834 St Clair Ave, St Paul, MN 55105'

      def get_list
        page.search('p.MsoNormal').map(&:text)
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
