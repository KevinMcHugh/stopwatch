require 'curses'
def time_interval
	ENV['TIME_INTERVAL'].to_f || 1
end

def print_timer(message_window,timer_window,max_seconds,message)
	message_window.clear
	message_window.addstr(message)
	message_window.refresh

	(0..max_seconds).each do |i|
		seconds_remaining = (max_seconds -i).to_i
		minutes = seconds_remaining / 60
		seconds = seconds_remaining % 60
		timer_window.clear
		timer_window.addstr("#{minutes}:#{seconds} / #{max_seconds}")
		timer_window.refresh
		sleep time_interval
	end
end

Curses.init_screen

begin
	x = Curses.lines / 2
	y = Curses.cols / 2
	message_window = Curses::Window.new(x,y,x,y-1)

	timer_window = Curses::Window.new(x, y, x + 1, y + 1)

	mappings = { "push ups" => 1, "shadow boxing" => 3, "sit ups" => 1 }
	max = 0.1
	mappings.each_pair do |message, max_minutes|
		max_seconds = max_minutes * 60
		print_timer(message_window, timer_window, max_seconds, message)
	end

	3.times do
		message_window.clear
		message_window.refresh
		sleep time_interval / 10.0
		message_window.addstr("Time's up!!!")
		message_window.refresh
		sleep time_interval / 2.0
	end
ensure
	Curses.close_screen
end