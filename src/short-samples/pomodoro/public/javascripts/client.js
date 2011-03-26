(function() {
  var format_countdown, pomodoro_object, show_pomodoro_timer, sound_alarm, toggle_buttons;
  show_pomodoro_timer = function(e) {
    console.log($(this).attr('id'));
    $('#todo_form').hide();
    return $('#pomodoro').show();
  };
  toggle_buttons = function() {
    var a, b;
    a = $('button#pomodoro_interrupt').attr('disabled');
    b = $('button#pomodoro_start').attr('disabled');
    $('button#pomodoro_interrupt').attr('disabled', !a);
    return $('button#pomodoro_start').attr('disabled', !b);
  };
  sound_alarm = function() {
    return $('#audiofile')[0].play();
  };
  pomodoro_object = {
    InitialRemainingTime: 1000 * 60 * 25,
    InitialInterruptTime: 1000 * 15,
    remainingTime: -1,
    interruptTime: -1
  };
  format_countdown = function(milliseconds) {
    var minutesRemaining, secondsRemaining;
    secondsRemaining = milliseconds % 60000;
    minutesRemaining = (milliseconds - secondsRemaining) / 60000;
    secondsRemaining = secondsRemaining / 1000;
    if (secondsRemaining < 10) {
      secondsRemaining = "0" + secondsRemaining;
    }
    if (minutesRemaining < 10) {
      minutesRemaining = "0" + minutesRemaining;
    }
    return minutesRemaining + ":" + secondsRemaining;
  };
  $(document).ready(function() {
    var interruptTime, intervalID, pomodoroTick, remainingTime;
    console.log("pomotodo ready");
    intervalID = null;
    remainingTime = 1000 * 60 * 1;
    $('ul#todo_list li').click(show_pomodoro_timer);
    $('h1#pomodoro_timer').text(format_countdown(remainingTime));
    pomodoroTick = function() {
      remainingTime = remainingTime - 1000;
      $('h1#pomodoro_timer').text(format_countdown(remainingTime));
      if (remainingTime <= 0) {
        clearInterval(intervalID);
        return sound_alarm();
      }
    };
    $('button#pomodoro_start').click(function() {
      console.log("you started a pomodoro");
      intervalID = setInterval(pomodoroTick, 1000);
      return toggle_buttons();
    });
    interruptTime = 1000 * 15;
    $('button#pomodoro_interrupt').click(function() {
      var tick;
      console.log("you interrupted a pomodoro");
      tick = function() {
        interruptTime = interruptTime - 1000;
        $('#interrupt_timer').text(format_countdown(interruptTime));
        if (interruptTime <= 0) {
          return clearInterval(intervalID);
        }
      };
      clearInterval(intervalID);
      intervalID = setInterval(tick, 1000);
      $('#pomodoro_timer').toggle();
      $('#interrupt_timer').toggle();
      $('button#pomodoro_interrupt').attr('disabled', true);
      $('#pomodoro_resume').attr('disabled', false);
      return $('button#pomodoro_start').attr('disabled', true);
    });
    $('button#pomodoro_resume').click(function() {
      console.log("resume the pomodoro");
      clearInterval(intervalID);
      intervalID = setInterval(pomodoroTick, 1000);
      $('#pomodoro_timer').toggle();
      $('#interrupt_timer').toggle();
      $('button#pomodoro_interrupt').attr('disabled', false);
      $('button#pomodoro_resume').attr('disabled', true);
      $('button#pomodoro_start').attr('disabled', true);
      interruptTime = 1000 * 15;
      return $('#interrupt_timer').text(format_countdown(interruptTime));
    });
    return $('button#test_sound').click(function() {
      return sound_alarm();
    });
  });
}).call(this);
