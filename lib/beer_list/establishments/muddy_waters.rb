module BeerList
  module Establishments
    class MuddyWaters < Establishment
      URL = 'http://muddywatersmpls.com/booze.html'

      def get_list
        get_processed_list
      end

      def url
        URL
      end

      def get_processed_list
        all = page.search('div.graphic_textbox_layout_style_default p').map(&:text)

        all.pop get_wine_count(all.reverse)
        all
      end

      def get_wine_count(ary=[])
        count = 0
        ary.each do |e|
          count += 1
          break count if e.empty?
        end
      end
    end
  end
end
