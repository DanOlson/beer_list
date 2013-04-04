module BeerList
  
  class NoEstablishmentsError < StandardError
    def initialize(msg=nil)
      msg ||= "No establishments are registered"
      super msg
    end
  end
end
