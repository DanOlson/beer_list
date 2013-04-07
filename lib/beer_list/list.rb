module BeerList
  class List < Array
    attr_reader :establishment

    def initialize(ary, establishment)
      @establishment = establishment
      super ary.sort
    end

    def to_hash
      Hash[establishment, self.to_a]
    end

    alias :old_to_json :to_json
    
    def to_json
      to_hash.to_json
    end
  end
end
