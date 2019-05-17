require 'curses'
def time_interval
  (ENV['TIME_INTERVAL'] || 1).to_f
end

def print_timer(message_window,timer_window,max_minutes,message)
  max_seconds = 60 * max_minutes
  message_window.clear
  message_window.addstr(message)
  message_window.refresh

  (0..max_seconds).each do |i|
    seconds_remaining = (max_seconds -i).to_i
    minutes = seconds_remaining / 60
    seconds = seconds_remaining % 60
    timer_window.clear
    timer_window.addstr("#{minutes}:#{sprintf('%02d',seconds)} / #{max_minutes.to_i}:#{sprintf('%02d',(max_seconds % 60).to_i)}")
    timer_window.refresh
    sleep time_interval
  end
end

def flash(message_window,message)
  message_window.clear
  message_window.refresh
  sleep time_interval / 10.0
  message_window.addstr(message)
  message_window.refresh
  sleep time_interval / 2.0
end

Curses.init_screen

begin
  x = Curses.lines / 2
  y = Curses.cols / 2
  message_window = Curses::Window.new(x,y,x,y-1)
  timer_window = Curses::Window.new(x, y, x + 1, y)

  mappings = { "push ups" => 1.5, "shadow boxing" => 3, "sit ups" => 1 }
  mappings.each_pair do |message, max_minutes|
    print_timer(message_window, timer_window, max_minutes, message)
    flash(message_window,"")
  end

  3.times do
    flash(message_window,"Time's up!!!")
  end
ensure
  Curses.close_screen
end