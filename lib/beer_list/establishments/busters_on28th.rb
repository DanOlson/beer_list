module BeerList
  module Establishments
    class BustersOn28th < Establishment
      URL = 'http://busterson28th.com/bottles/'

      def get_list
        base_list
        split_on_newline
        reject_headers
        match_pre_vol
        reject_nils
      end

      def url
        URL
      end

      private

      def base_list
        @busters = page.search('p').map(&:text)
      end

      def split_on_newline
        @busters = @busters.map{ |beer| beer.split("\n") }.flatten
      end

      # First, select all entries that have a lowercase letter (headers do not)
      # At that point, there are still some headers mixed with beer names.
      # For example:
      #
      #   STOUTSurly Darkness
      #
      # Match group 3 or more capital letters followed by one cap and one lower
      # take the portion of the beer name after the match group
      def reject_headers
        @busters = @busters.select{ |beer| beer.match /[a-z]/ }
        @busters = @busters.map do |beer|
          beer.match(/([A-Z]{3,})[A-Z]{1}[a-z]{1}/) ? beer.split($1).last : beer
        end
      end

      def match_pre_vol
        @busters = @busters.map do |beer|
          beer.match(/\d{1,2}\.?\d*\s*oz/) ? $`.strip : nil
        end
      end

      def reject_nils
        @busters = @busters.reject(&:nil?)
      end
    end
  end
end
