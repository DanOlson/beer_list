class ThreeSquares < Establishment
  URL = 'http://www.3squaresrestaurant.com/beer_taps.php'

  def get_list
    @list = page.at('ul').text.split("\r\n")
  end

  def url
    URL
  end
end
