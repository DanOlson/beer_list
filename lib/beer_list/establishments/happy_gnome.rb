module BeerList
  module Establishments
    class HappyGnome < Establishment
      attr_accessor :url

      ADDRESS = '498 Selby Ave, St Paul, MN 55102'
      DRAFTS  = 'http://thehappygnome.com/menus/drafts/'
      BOTTLES = 'http://thehappygnome.com/menus/bottled-beers/'

      def initialize
        @url = DRAFTS
      end

      def get_list
        get_draft_list
        get_bottle_list
      end

      def address
        ADDRESS
      end

      private

      def get_the_list
        base_list
        match_before_paren
        reject_empty
      end

      def get_draft_list
        @beers = []
        @beers += get_the_list
      end

      def get_bottle_list
        self.url  = BOTTLES
        self.page = BeerList.scraper.visit self
        @beers    += get_the_list
      end

      def base_list
        @happy_gnome = page.search('p').map(&:text)
      end

      def match_before_paren
        @happy_gnome = @happy_gnome.map{ |b| b.match(/\(/); $` }
      end

      def reject_empty
        @happy_gnome = @happy_gnome.reject(&:nil?).map(&:strip)
      end
    end
  end
end
