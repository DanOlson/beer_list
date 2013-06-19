module BeerList
  module Establishments
    class RedCow < Establishment
      URL     = 'http://redcowmn.com/beer'
      ADDRESS = '3624 W 50th St, Minneapolis, MN 55410'

      def get_list
        base_list
        match_before_paren
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def base_list
        @red_cow = page.search('.sqs-block-content li').map(&:text)
      end

      def match_before_paren
        @red_cow = @red_cow.map { |b| b.match(/\(/) ? $`.strip : b.strip }
      end
    end
  end
end
