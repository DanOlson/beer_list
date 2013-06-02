module BeerList
  module Establishments
    class BlueNile < Establishment
      RESTAURANT_NAME = 'Blue Nile'
      URL             = 'http://www.bluenilempls.com/bar-b.html'
      ADDRESS         = '2027 E Franklin Ave, Minneapolis, MN 55404'

      def get_list
        base_list
        trim
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def headers
        @headers ||= remove_carraige_and_strip(page.search('.style5').map(&:text))
      end

      def base_list
        @beers = remove_carraige_and_strip(page.search('p').map(&:text)).reject{ |b| headers.include? b }
        remove_contact_info
      end

      def trim
        trim_cost_and_origin
        trim_volume
        reject_non_word_entries
      end

      def trim_cost_and_origin
        @beers = @beers.map{ |b| b.split('(').first }.map{ |b| b.split(' $').first }
      end

      def trim_volume
        @beers = @beers.map{ |b| b.match(/,?\s?\d+\s?(ml|oz|0z)/) ? $`.strip : b.strip }
      end

      def reject_non_word_entries
        @beers = @beers.reject{ |b| b.match /\A\W\z/ }
      end

      def remove_contact_info
        index = @beers.index(RESTAURANT_NAME)
        @beers.pop @beers.size - index
      end

      def remove_carraige_and_strip(ary)
        ary.map{ |b| b.split("\r").map(&:strip) }.flatten.reject(&:empty?)
      end
    end
  end
end
