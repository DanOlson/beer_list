module BeerList
  module Establishments
    class Icehouse < Establishment
      URL     = 'http://www.icehousempls.com/drinks/beer/'
      ADDRESS = "2528 Nicollet Ave, Minneapolis, MN 55404"

      def get_list
        base_list
        only_caps
        reject_empty
        capitalize
      end

      def url
        URL
      end

      def address
        ADDRESS
      end

      private

      def base_list
        @icehouse = page.search('article#menu dd').map(&:text)
      end

      def only_caps
        @icehouse = @icehouse.map { |b| b.match(/\A([0-9]+)?\s?([A-Z]+\s?)+/).to_s }
      end

      def reject_empty
        @icehouse = @icehouse.reject { |b| b.empty? }
      end

      def capitalize
        @icehouse.map do |b|
          b.split(' ').map(&:capitalize).join(' ')
        end
      end
    end
  end
end
