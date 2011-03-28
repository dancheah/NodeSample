(function() {
  var Pomodoro, format_countdown, show_pomodoro_timer, sound_alarm, toggle_buttons;
  Pomodoro = Backbone.Model.extend({
    defaults: {
      "remainingTime": 1000 * 60 * 25,
      "interruptTime": 1000 * 15,
      "state": "stopped"
    },
    pomodoroTick: function() {
      return this.set({
        "remainingTime": this.get("remainingTime") - 1000
      });
    },
    start: function() {
      return this.set({
        state: "start"
      });
    },
    interrupt: function() {
      return this.set({
        state: 'interrupt'
      });
    },
    resume: function() {
      return this.set({
        state: "inprogress"
      });
    }
  });
  show_pomodoro_timer = function(e) {
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
    var interruptTime, intervalID, pomodoro, remainingTime;
    pomodoro = new Pomodoro();
    console.log("pomotodo ready");
    intervalID = null;
    remainingTime = 1000 * 60 * 1;
    $('ul#todo_list li').click(show_pomodoro_timer);
    $('h1#pomodoro_timer').text(format_countdown(remainingTime));
    $('button#pomodoro_start').click(function() {
      intervalID = setInterval(_.bind(pomodoro.pomodoroTick, pomodoro), 1000);
      return toggle_buttons();
    });
    interruptTime = 1000 * 15;
    $('button#pomodoro_interrupt').click(function() {
      var tick;
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
