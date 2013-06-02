module BeerList
  class List < Array
    attr_reader :listable

    def initialize(opts={})
      ary       = opts[:array] || []
      @listable = opts[:listable]
      super ary.sort
    end

    def to_hash
      { name: listable.name, address: listable.address, list: to_a }
    end

    alias :old_to_json :to_json
    
    def to_json
      to_hash.to_json
    end

    def listable_name
      listable.name
    end
  end
end
