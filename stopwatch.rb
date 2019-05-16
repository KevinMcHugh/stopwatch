require 'curses'
Curses.init_screen
time_interval = 1

begin
	x = Curses.lines / 2  # We will center our text
	y = Curses.cols / 2
	# Curses.setpos(1, 1)  # Move the cursor to the center of the screen
	message = Curses::Window.new(x,y,x,y-1)

	timer = Curses::Window.new(x, y, x + 1, y + 1)

	message.addstr("This is a timer.")
	message.refresh

	mappings = { "push ups" => 1, "shadow boxing" => 3, "sit ups" => 1 }
	max = 0.1
	max_seconds = max * 60
	(0..max_seconds).each do |i|
		seconds_remaining = (max_seconds -i).to_i
		minutes = seconds_remaining / 60
		seconds = seconds_remaining % 60
		timer.clear
		timer.addstr("#{minutes}:#{seconds} / #{max_seconds}")
		timer.refresh
		sleep time_interval
	end
	3.times do
		message.clear
		message.refresh
		sleep time_interval / 10.0
		message.addstr("Time's up!!!")
		message.refresh
		sleep time_interval / 2.0
	end
ensure
	Curses.close_screen
end