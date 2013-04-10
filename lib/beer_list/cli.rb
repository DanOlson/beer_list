module BeerList
  class CLI

    def initialize(args)
      @args = args
    end

    def establish(klass)
      BeerList::EstablishmentGenerator.new(klass, @args)
    end
  end
end
