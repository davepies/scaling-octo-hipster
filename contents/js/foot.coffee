require './autoplayVideo'
modal = require 'modal'
require 'carousel'

modal.init()

$ ->
  $('.team-carousel').owlCarousel
    singleItem: true
    transitionStyle: 'backSlide'

  carousel = $('.team-carousel').data 'owlCarousel'

  teamControls = $('.team-controls')

  teamControls.bind 'click', (e) ->
    e.preventDefault()
    carousel.next()
