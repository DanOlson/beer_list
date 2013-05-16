module BeerList
  module Establishments
    class AcadiaCafe < Establishment
      URL = 'http://acadiacafe.com/as_beer-menu-and-happy-hour-specials'

      def get_list
        base_list
        having_price_and_abv
        match_before_comma
      end

      def url
        URL
      end

      private

      def base_list
        @acadia = page.search('p').map(&:text)
      end

      def having_price_and_abv
        @acadia = @acadia.select{ |str| str.match(/\d{1,2}\.\d{1,2}%+.*\$+/) }
      end

      def match_before_comma
        @acadia = @acadia.map{ |b| b.match(/,{1}/); $` }.reject(&:nil?).map(&:strip)
      end
    end
  end
end
