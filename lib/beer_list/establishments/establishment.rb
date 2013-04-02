class Establishment
  attr_reader :page

  def initialize
    @page = Scraper.new(url).page
  end

  def to_json
    JSON.dump(self.class.name => get_list)
  end

  def url
    raise "#{__method__} is not implemented in #{self.class.name}"
  end
end
