module BeerList
  module Establishments
    class WashingtonSquare < Establishment
      URL = 'http://www.washingtonsquareonline.net/as_on-tap'

      def get_list
        base_list
        remove_facebook_plug
        remove_nbsp
      end

      def url
        URL
      end

      private

      def base_list
        @results = page.search('p strong').map(&:text)
      end

      def remove_facebook_plug
        @results.shift
      end

      def remove_nbsp
        @results = @results.map{ |b| b.gsub(/[[:space:]]{2,}/, '') }
      end
    end
  end
end