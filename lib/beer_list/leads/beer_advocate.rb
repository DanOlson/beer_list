module BeerList
  module Leads
    class BeerAdvocate
      include BeerList::Listable

      BEERFLY = 'http://beeradvocate.com/beerfly/list'

      def links
        @links ||= page.links_with(:text => 'official website').map(&:href)
      end
      alias :get_list :links

      def url
        "#{BEERFLY}?c_id=US&s_id=#{short_class_name}&bar=Y"
      end

      private

      def short_class_name
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
      const_set state, Class.new(BeerAdvocate)
    end
  end
end
