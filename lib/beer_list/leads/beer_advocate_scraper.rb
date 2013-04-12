module BeerList
  module Leads
    class BeerAdvocateScraper
      attr_reader :page

      BEERFLY = 'http://beeradvocate.com/beerfly/list'

      def initialize
        @agent = Mechanize.new
        @agent.user_agent = 'Mac Safari'
        @page  = @agent.get url
      end

      def links
        @links ||= page.links_with(:text => 'official website').map(&:href)
      end

      private

      def url
        "#{BEERFLY}?c_id=US&s_id=#{short_name}&bar=Y"
      end

      def short_name
        self.class.name.split('::').last
      end
    end

    %w{
      AL
      AK
      AZ
      AR
      CA
      CO
      CT
      DE
      FL
      GA
      HI
      ID
      IL
      IN
      IA
      KS
      KY
      LA
      ME
      MD
      MA
      MI
      MN
      MS
      MO
      MT
      NE
      NV
      NH
      NJ
      NM
      NY
      NC
      ND
      OH
      OK
      OR
      PA
      RI
      SC
      SD
      TN
      TX
      UT
      VT
      VA
      WA
      WV
      WI
      WY
    }.each do |state|
      const_set state, Class.new(BeerAdvocateScraper)
    end
  end
end
