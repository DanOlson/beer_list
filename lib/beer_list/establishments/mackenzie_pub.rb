module BeerList
  module Establishments
    class MackenziePub < Establishment
      URL     = 'http://mackenziepub.com/drink/beer/'
      ADDRESS = '918 Hennepin Ave, Minneapolis, MN 55403'

      def get_list
        base_list
        strip_leading_star
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def base_list
        @beers = page.search('div.menu-container-cell-description h4').map(&:text)
      end

      def strip_leading_star
        @beers = @beers.map{ |beer| beer.gsub(/\A\*/, '') }
      end
    end
  end
end
