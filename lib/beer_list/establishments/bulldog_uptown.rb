module BeerList
  module Establishments
    class BulldogUptown < Establishment
      URL     = 'http://www.thebulldoguptown.com/beer/'
      ADDRESS = '2549 Lyndale Ave S, Minneapolis, MN 55405'

      def get_list
        list = page.search('span.menuTitle').map(&:text)
        list = process_list list
      end

      def process_list(list)
        list.pop 5
        list.map{ |e| e.split(' (').first }
      end

      def url
        URL
      end

      def address
        ADDRESS
      end
    end
  end
end
