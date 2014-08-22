require 'froogaloop'

hiwVid = document.getElementById 'hiw-vid'
player = $f(hiwVid)

playVid = ->
  player.api 'play'

pauseVid = ->
  player.api 'pause'

$(document).on('cssmodal:show', playVid)
$(document).on('cssmodal:hide', pauseVid)

$('a[href*=modal]').bind 'click', (e) ->
  e.preventDefault()
  super()
