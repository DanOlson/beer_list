$LOAD_PATH.unshift(File.dirname(__FILE__))

module BeerList
  module Establishments
    require 'establishments/establishment'
    require 'establishments/three_squares'
    require 'establishments/groveland_tap'
    require 'establishments/edina_grill'
    require 'establishments/longfellow_grill'
    require 'establishments/muddy_waters'
  end
end
