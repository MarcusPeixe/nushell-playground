let W = (term size).columns     # Find terminal width.
let H = (term size).rows - 2    # Find terminal height.
let N = $W * $H * 0.02          # Snowflake count.

def setpixel [ i: int j: int ] {(   # Matrix of characters is piped in,
  if $i >= 0 {                      # character at (i, j) is set to '❄️',
    update $i { update $j '❄️' };    # and matrix is piped out.
  }
  else {}
)}

def render [] {       # Render matrix of characters.
  each { each { print -n }; print "" } | ignore
}

def update_snow [] {      # Update snowflake's position. A snowflake is
  let prev = $in;         # a simple { i: int j: int} record.
  let i = ($prev.i + (random int (1..2)));
  let j = ($prev.j + (random int (-2..2)));
  {
    i: (if $i >= $H { 0 } else { $i })    # If snowflake hits the ground, teleport it back up.
    j: ([0 $j ($W - 1)] | math median)    # Keep snowflake within horizontal bounds.
  }
}

let scr = (1..$H | each { 1..$W | each { ' ' } });  # Generate matrix of characters
let delay = (1sec / 60);                            # Set *approximate* delay between frames
mut snow = (1..$N | each {{                         # Generate snowflakes (table of (i, j) pairs)
  i: (random int (($W * -1)..-1))
  j: ((random int (1..$W)) - 1)
}});

clear
print (ansi cursor_off)
loop {
  print (ansi home)
  $snow = ($snow | each { update_snow });     # Update each snowflake.
  (
    $snow       # Call 'setpixel' on 'scr' for each snowflake, then render matrix.
    | reduce --fold $scr { |it acc| $acc | setpixel $it.i $it.j }
    | render
  );
  sleep $delay    # Sleep for a bit.
}
