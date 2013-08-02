module BeerList
  module Establishments
    class Bunnys < Establishment
      URL     = 'http://bunnysbarandgrill.com/beer/'
      ADDRESS = '5916 Excelsior Blvd, St Louis Park, MN 55416'

      def get_list
        base_list
        split_on_newline
        reject_beer_of_the_month
        match_before_paren
        add_beer_of_the_month
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def base_list
        @beers = page.search('.entry-content p').map &:text
      end

      def split_on_newline
        @beers = @beers.map { |b| b.split "\n" }.flatten
      end

      def reject_beer_of_the_month
        @beers = @beers.reject { |b| b.match /beer of the month/i }
      end

      def match_before_paren
        @beers = @beers.map { |b| b.match(/\(/) ? $`.strip : b }
      end

      def add_beer_of_the_month
        botm = page.search('.hjawidget h1').map &:text
        @beers += botm
        @beers.uniq
      end
    end
  end
end
