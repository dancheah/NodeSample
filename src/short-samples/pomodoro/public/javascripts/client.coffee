show_pomodoro_timer = (e) -> 
  console.log($(this).attr('id'))
  $('#todo_form').hide()
  $('#pomodoro').show()

toggle_buttons = () ->
    a = $('button#pomodoro_interrupt').attr('disabled')
    b = $('button#pomodoro_start').attr('disabled')
    $('button#pomodoro_interrupt').attr('disabled', !a)
    $('button#pomodoro_start').attr('disabled', !b)

sound_alarm = () ->
  $('#audiofile')[0].play()

pomodoro_object =
  # 25 Minutes
  InitialRemainingTime: 1000 * 60 * 25 

  # 15 Seconds
  InitialInterruptTime: 1000 * 15

  remainingTime: -1
  interruptTime: -1

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
  # TODO: The logic in here is getting complicated. Time to
  # refactor it
  console.log("pomotodo ready")

  intervalID = null

  # 25 minutes
  remainingTime = 1000 * 60 * 1 

  $('ul#todo_list li').click(show_pomodoro_timer)

  $('h1#pomodoro_timer').text(format_countdown(remainingTime))

  pomodoroTick = () ->
    remainingTime = remainingTime - 1000
    $('h1#pomodoro_timer').text(format_countdown(remainingTime))

    if remainingTime <= 0
      clearInterval(intervalID)
      sound_alarm()

  $('button#pomodoro_start').click(() ->
    console.log("you started a pomodoro")
    intervalID = setInterval(pomodoroTick, 1000)
    toggle_buttons()
  )

  # 15 seconds
  interruptTime = 1000 * 15

  $('button#pomodoro_interrupt').click(() -> 
    console.log("you interrupted a pomodoro")

    tick = () -> 
      interruptTime = interruptTime - 1000
      $('#interrupt_timer').text(format_countdown(interruptTime))

      if interruptTime <= 0
        clearInterval(intervalID)

    clearInterval(intervalID)
    intervalID = setInterval(tick, 1000)

    $('#pomodoro_timer').toggle()
    $('#interrupt_timer').toggle()

    $('button#pomodoro_interrupt').attr('disabled', true)
    $('#pomodoro_resume').attr('disabled', false)
    $('button#pomodoro_start').attr('disabled', true)
  )

  $('button#pomodoro_resume').click(() ->
    console.log("resume the pomodoro")
    clearInterval(intervalID)
    intervalID = setInterval(pomodoroTick, 1000)

    $('#pomodoro_timer').toggle()
    $('#interrupt_timer').toggle()

    $('button#pomodoro_interrupt').attr('disabled', false)
    $('button#pomodoro_resume').attr('disabled', true)
    $('button#pomodoro_start').attr('disabled', true)
    interruptTime = 1000 * 15
    $('#interrupt_timer').text(format_countdown(interruptTime))
  )


  $('button#test_sound').click(() ->
    sound_alarm()
  )
)

# vim: sts=2 sw=2 ts=2 et 
