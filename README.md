# Beer List

A utility for retrieving the beer list from various establishments

## Usage

`require 'beer_list'`

See what's on tap:

```
# An array-like object
list = BeerList.groveland_tap

# As a hash
list.to_hash

# As JSON
list.to_json
```
