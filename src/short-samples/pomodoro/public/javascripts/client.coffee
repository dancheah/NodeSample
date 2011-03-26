show_pomodoro_timer = (e) -> 
  console.log($(this).attr('id'))
  $('#todo_form').hide()
  $('#pomodoro_timer').show()

toggle_buttons = () ->
    a = $('button#pomodoro_interrupt').attr('disabled')
    b = $('button#pomodoro_start').attr('disabled')
    $('button#pomodoro_interrupt').attr('disabled', !a)
    $('button#pomodoro_start').attr('disabled', !b)

sound_alarm = () ->
  $('#audiofile')[0].play()

format_countdown = (milliseconds) ->
  secondsRemaining = milliseconds % 60000 
  minutesRemaining = (milliseconds - secondsRemaining) / 60000
  secondsRemaining = secondsRemaining / 1000
  if secondsRemaining < 10
    secondsRemaining = "0" + secondsRemaining
  if minutesRemaining < 10
    minutesRemaining = "0" + minutesRemaining

  return minutesRemaining + ":" + secondsRemaining

$(document).ready(() ->
  intervalID = null

  # 25 minutes
  remainingTime = 1000 * 60 * 1 

  console.log("pomotodo ready")

  $('ul#todo_list li').click(show_pomodoro_timer)

  $('button#pomodoro_start').click(() ->
    tick = (t) ->
      remainingTime = remainingTime - 1000
      $('h1#display_timer').text(format_countdown(remainingTime))

      if remainingTime <= 0
        clearInterval(intervalID)
        sound_alarm()

    console.log("you started a pomodoro")
    intervalID = setInterval(tick, 1000)
    toggle_buttons()
  )

  $('button#pomodoro_interrupt').click(() -> 
    console.log("you interrupted a pomodoro")
    clearInterval(intervalID)
    toggle_buttons()
  )

  $('button#test_sound').click(() ->
    console.log("play a sound!")
    sound_alarm()
  )
)

# vim: sts=2 sw=2 ts=2 et 
