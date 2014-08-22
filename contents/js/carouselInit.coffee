module.exports = ->
  $('.team-carousel').owlCarousel
    singleItem: true
    transitionStyle: 'backSlide'

  # Grab the carousel so we can control it
  carousel = $('.team-carousel').data 'owlCarousel'

  # Simple switch between carousel pages
  teamControls = $('.team-controls')
  teamControls.bind 'click', (e) ->
    e.preventDefault()
    carousel.next()
