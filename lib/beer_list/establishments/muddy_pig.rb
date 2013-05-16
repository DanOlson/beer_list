module BeerList
  module Establishments
    class MuddyPig < Establishment
      URL = 'http://muddypig.com/beer/'

      def get_list
        page.search('p').last.text.split("\n")
      end

      def url
        URL
      end
    end
  end
end
