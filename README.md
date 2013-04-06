# Beer List

A utility for retrieving the beer list from various establishments

## Usage

`gem install beer_list

or in your gemfile:

`gem 'beer_list'`


`require 'beer_list'`

### Getting a List

See what's on tap:

```
# An array-like object
list = BeerList.groveland_tap

# As a hash
list.to_hash

# As JSON
list.to_json
```

You may want to get lists for more than one establishment at a time. To do so, register
the desired establishments in BeerList.establishments:

```
three_squares = BeerList::Establishments::ThreeSquares.new
muddy_waters  = BeerList::Establishments::MuddyWaters.new

BeerList.establishments << three_squares
BeerList.establishments << muddy_waters

# Array of BeerList::List objects
BeerList.lists

# As a hash
BeerList.list_as_hash

# As JSON
BeerList.list_as_json
```

The Lists will be memoized until the content of BeerList.establishments changes so that
The establishments don't have to be re-scraped each time the list is requested.

### Extending BeerList with More Establishments

BeerList ships with a limited number of establishments, but it's easy to write your own.
Your establishment class must inherit from BeerList::Establishments::Establishment,
and provide two instance methods: `get_list` and `url`. `url` should be the url of the beer list on your establishment's website. `get_list` should handle parsing and 
manipulating a Mechanize::Page object in order to scrape the contents of your beer list.

For example:

```
module BeerList
  module Establishments
    class Applebirds
      URL = 'http://applebirds.com/beers'

      def get_list
        page.search('p.beer').map(&:text)
      end

      def url
        URL
      end
    end
  end
end
```

Checkout [This link](http://mechanize.rubyforge.org/) for more on Mechanize
