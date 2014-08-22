require 'jquery'
video = require './autoplayVideo'
modal = require 'modal'
require 'carousel'
carousel = require './carouselInit'

modal.init()

$ ->
  carousel()
  video()
