let W = (term size).columns     # Find terminal width.
let H = (term size).rows - 2    # Find terminal height.
let chance = 0.01               # Snowflake density.

def update_snow [] {(   # Perform clever rotate tricks to simulate snowfall.
  each { roll down -b ($W + (random int (-2..2))) }
  | roll down -b (random int 1..2)
)}

let delay = (1sec / 60);    # Set *approximate* delay between frames.

mut scr = (1..$H | each { 1..$W | each {    # Generate matrix of characters.
  if (random bool -b $chance) { '❄️' } else { ' ' }
}});

clear
print (ansi cursor_off)
loop {
  print (ansi home)
  $scr = ($scr | update_snow);    # Update snow.
  $scr | each { each { print -n }; print "" };    # Render matrix.
  sleep $delay    # Sleep for a bit.
}
