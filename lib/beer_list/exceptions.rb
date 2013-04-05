module BeerList
  
  class NoEstablishmentsError < StandardError
    def initialize(msg=nil)
      msg ||= "No establishments are registered"
      super msg
    end
  end

  class NoScraperError < StandardError
    def initialize(msg=nil)
      msg ||= "No scraper is registered"
      super msg
    end
  end
end
