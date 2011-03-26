(function() {
  var format_countdown, show_pomodoro_timer, sound_alarm, toggle_buttons;
  show_pomodoro_timer = function(e) {
    console.log($(this).attr('id'));
    $('#todo_form').hide();
    return $('#pomodoro_timer').show();
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
    var intervalID, remainingTime;
    intervalID = null;
    remainingTime = 1000 * 60 * 1;
    console.log("pomotodo ready");
    $('ul#todo_list li').click(show_pomodoro_timer);
    $('button#pomodoro_start').click(function() {
      var tick;
      tick = function(t) {
        remainingTime = remainingTime - 1000;
        $('h1#display_timer').text(format_countdown(remainingTime));
        if (remainingTime <= 0) {
          clearInterval(intervalID);
          return sound_alarm();
        }
      };
      console.log("you started a pomodoro");
      intervalID = setInterval(tick, 1000);
      return toggle_buttons();
    });
    $('button#pomodoro_interrupt').click(function() {
      console.log("you interrupted a pomodoro");
      clearInterval(intervalID);
      return toggle_buttons();
    });
    return $('button#test_sound').click(function() {
      console.log("play a sound!");
      return sound_alarm();
    });
  });
}).call(this);
