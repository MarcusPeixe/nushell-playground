# Nushell playground

This repo is a playground for nushell scripts.

## snow.nu

This is a snow simulation running in the terminal, in ~45 lines. It
simulates each snowflake individually, then renders all of them. This
version is quite slow.

## snow2.nu

This one is another, slightly more optimised version of the snow simulation.
Instead of simulating and rendering each snowflake individually, it keeps
manipulating the character matrix by whole lines at a time. This means that
the snow pattern doesn't really change, and this makes it quite repetitive.
On the other hand, it is a bit faster than the previous version.
