(function() {
  var show_pomodoro_timer, tick;
  show_pomodoro_timer = function(e) {
    console.log($(this).attr('id'));
    $('#todo_form').hide();
    return $('#pomodoro_timer').show();
  };
  tick = function(t) {
    console.log("tick");
    return $('h1#display_timer').text(t[5] + ':' + t[6]);
  };
  $(document).ready(function() {
    console.log("pomotodo ready");
    $('ul#todo_list li').click(show_pomodoro_timer);
    $('button#pomodoro_start').click(function() {
      console.log("you started a pomodoro");
      return $('p#countdown_timer').countdown({
        until: '+25m',
        onTick: tick
      });
    });
    return $('button#pomodoro_interrupt').click(function() {
      return console.log("you interrupted a pomodoro");
    });
  });
}).call(this);
