show_pomodoro_timer = (e) -> 
  console.log($(this).attr('id'))
  $('#todo_form').hide()
  $('#pomodoro_timer').show()

tick = (t) ->
  console.log("tick")
  $('h1#display_timer').text(t[5] + ':' + t[6])

$(document).ready(() ->
  console.log("pomotodo ready")

  $('ul#todo_list li').click(show_pomodoro_timer)

  $('button#pomodoro_start').click(() ->
    console.log("you started a pomodoro")
    $('p#countdown_timer').countdown({until: '+25m', onTick: tick})
  )

  $('button#pomodoro_interrupt').click(() -> 
    console.log("you interrupted a pomodoro")
  )
)

# vim: sts=2 sw=2 ts=2 et 
