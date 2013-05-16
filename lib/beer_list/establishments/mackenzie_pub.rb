module BeerList
  module Establishments
    class MackenziePub < Establishment
      URL = 'http://mackenziepub.com/drink/beer/'

      def get_list
        base_list
        strip_leading_star
      end

      def url
        URL
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