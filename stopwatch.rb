require 'curses'
Curses.init_screen
begin
	x = Curses.lines / 2  # We will center our text
	y = Curses.cols / 2
	# Curses.setpos(1, 1)  # Move the cursor to the center of the screen
	message = Curses::Window.new(x,y,x,y-1)

	timer = Curses::Window.new(x, y, x + 1, y + 1)

	message.addstr("This is a timer.")
	message.refresh

	max = 5
	(1..max).each do |i|
		timer.clear
		timer.addstr("#{max - i} / #{max}")
		timer.refresh
		sleep 1
	end
ensure
	Curses.close_screen
end