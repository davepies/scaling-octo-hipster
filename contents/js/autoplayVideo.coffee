require 'froogaloop'

module.exports = ->
  hiwVid = document.getElementById 'hiw-vid'
  player = $f(hiwVid)

  playVid = ->
    player.api 'play'

  pauseVid = ->
    player.api 'pause'

  $('.hiw-vid a').bind 'click', ->
    playVid()
  $(document).on('cssmodal:hide', pauseVid)
