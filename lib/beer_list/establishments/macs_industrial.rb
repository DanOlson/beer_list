module BeerList
  module Establishments
    class MacsIndustrial < Establishment
      URL = 'http://www.macsindustrial.com/tap_page.php'

      def get_list
        build_list
      end

      def url
        URL
      end

      private

      def build_list
        breweries.zip(beers).map{ |b| b.join(' ') }
      end

      def base_list
        @macs ||= page.search('tr:first-child td:last-child')
      end

      def breweries
        base_list.search('a strong').children.map(&:text)
      end

      def beers
        base_list.search('span strong').children.map(&:text).map{ |b| b[1..-1] }
      end
    end
  end
end
