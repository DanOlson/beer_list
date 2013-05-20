module BeerList
  
  class NoEstablishmentsError < StandardError
    def initialize(msg=nil)
      msg ||= "No establishments are registered"
      super msg
    end
  end

  class NoUrlError < StandardError
    def initialize(msg=nil)
      msg ||= "No url was specified and no default_url exists"
      super msg
    end
  end

  class NotAListError < StandardError
    def initialize(msg=nil)
      msg ||= "That object was not a BeerList::List"
      super msg
    end
  end
end
