module BeerList
  module Establishments
    class NewBohemia < Establishment
      URL = 'http://www.newbohemiausa.com/bier/'

      def get_list
        base_list
        strip
      end

      def url
        URL
      end

      private

      def base_list
        @beers = [left, right].inject([]) do |ary, collection|
          ary += match_before_slash(collection).compact
        end
      end

      def strip
        @beers = @beers.map{ |beer| beer.gsub(/\A\W*|\W*\z/, '') }
      end

      def left
        split_on_newline(left_column).flatten
      end

      def right
        right_column
      end

      def left_column
        page.search('div.col-left p').map(&:text)
      end

      def right_column
        page.search('div.col-right p span').map(&:text)
      end

      def split_on_newline(beers)
        beers.inject([]) { |ary, string| ary << string.split("\n") }
      end

      def match_before_slash(beers)
        beers.map{ |beer| beer.match(/\A([^\/]+)\/{1}/); $1 }
      end
    end
  end
end
