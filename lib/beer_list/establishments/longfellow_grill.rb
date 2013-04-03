module BeerList
  module Establishments
    class LongfellowGrill < Establishment
      URL = 'http://www.longfellowgrill.com/beer_taps.php'
      STATE_AND_PRICE_REGEX = /\s*(?:\([A-Z]*\))*\s*\**\s*\d+\.\d{2}$/

      def get_list
        get_base_list
        process_base_list
        @list
      end

      def url
        URL
      end

      private

      def get_base_list
        @list = page.search('li span').map(&:text)
      end

      def process_base_list
        remove_not_applicable
        remove_special_chars
        trim_list_items
      end

      def remove_not_applicable
        @list = @list.reject{ |e| e.match(/\A\s+\Z|\A\((.*)\)/) }
      end

      def remove_special_chars
        @list = @list.map(&:strip).map{ |e| e.gsub(/\u00a0/, '') }
      end

      def trim_list_items
        @list = @list.map{ |e| e.gsub(STATE_AND_PRICE_REGEX, '') }.uniq
      end
    end
  end
end
