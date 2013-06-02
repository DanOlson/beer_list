module BeerList
  module Establishments
    class MuddyPig < Establishment
      URL   = 'http://muddypig.com/beer/'
      ADDRESS = '162 Dale St N, St Paul, MN 55102'

      def get_list
        page.search('p').last.text.split("\n")
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
