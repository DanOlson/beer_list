# Beer List

A utility for retrieving the beer list from various establishments

## Usage

`gem install beer_list`

or in your gemfile:

`gem 'beer_list'`

then require the gem:

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

### Establishments

Establishments peddle delicious beers. You're interested in which delicious beers a
given establishment is peddling. To reconcile this situation, you need one or more 
BeerList::Establishments. BeerList ships with a limited number of establishments, 
but its easy to [extend BeerList](#extending-beerlist-with-more-establishments) with more.

First, let's try one out of the box:

```
bulldog_northeast = BeerList::Establishments::BulldogNortheast.new

# Now get the list
bulldog_northeast.list
```

You may want to get lists for more than one establishment at a time. To do so, register
the desired establishments in BeerList.establishments:

```
three_squares = BeerList::Establishments::ThreeSquares.new
muddy_waters  = BeerList::Establishments::MuddyWaters.new

# Register establishments
BeerList.add_establishments(three_squares, muddy_waters)

# See your registered establishments
BeerList.establishments

# Get the beer lists at your registered establishments.
# as an array of BeerList::List objects
BeerList.lists

# As a hash
BeerList.lists_as_hash

# As JSON
BeerList.lists_as_json
```

The Lists will be memoized until the content of BeerList.establishments changes so that
the establishments don't have to be re-scraped each time the list is requested.

### Extending BeerList with More Establishments

BeerList includes an executable to easily create your own establishments.

For example:

`$ beer_list establish Applebirds -u http://applebirds.com/beers -d path/to/establishments`

will create the following code in path/to/establishments/applebirds.rb

```
module BeerList
  module Establishments
    class Applebirds < Establishment
      URL = 'http://applebirds.com/beers'

      # Handles parsing and manipulating a Mechanize::Page object
      # in order to scrape the contents of your beer list.
      #
      # Uncomment and implement to your liking.
      def get_list
        # page.search('.selector').map(&:text)
      end

      def url
        URL
      end
    end
  end
end

```

For all options you can pass to beer_list establish, run:

`$ beer_list help`

### Using Your Generated Establishments

So you've written some pretty bad-ass scrapers now, and you're ready to actually
use the fruit of your labor in a real application. You'll need to tell BeerList
about the generated files so that it can require them. If you're using Rails, add
the following code in an initializer:

`BeerList.establishments_dir = File.join(Rails.root, 'path/to/establishments')`


```
# Fetch just the list at Applebirds
BeerList.applebirds

# Or, register your establishment
BeerList.add_establishment(BeerList::Establishments::Applebirds.new)

# fetch all your registered lists, including the one at Applebirds
BeerList.lists

```

See [Getting A List](#getting-a-list) for more details.

AND...

Checkout [This link](http://mechanize.rubyforge.org/) for more on Mechanize

### Leads

If you're out of ideas on what establishments you may want lists for, fear not: BeerList can
give you some ideas.

```
# You might be interested in good beer bars located in California:
cali = BeerList::Leads::CA.new

# returns a BeerList::List of URLs for popular beer bars in California
cali.list


# Maybe you want Wisconsin:
wi = BeerList::Leads:WI.new

wi.list

```

So far, support for this feature is limited to the United States. Hopefully, I can expand
it in the not-too-distant future.

### CLI

In addition to the [establish](#extending-beerlist-with-more-establishments) command, which
generates Establishment files for you, BeerList also offers the `list` command. For example,
say you have the following two establishments a directory called ~/my_beer_lists:

```
BeerList::Establishments::Applebirds
BeerList::Establishments::Thursdays
```

You can get the beer lists for these places from the command line:

```
$ beer_list list applebirds -d ~/my_beer_lists

# or
$ beer_list list applebirds thursdays -d ~/my_beer_lists

# pass -j for JSON
$ beer_list list applebirds thursdays -j -d ~/my_beer_lists
```
