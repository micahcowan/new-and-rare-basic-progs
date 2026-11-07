# New And Rare BASIC Programs

“New And Rare BASIC Programs” was written by Nils Andreas and Dave Hassler,
and published by Dave’s publishing house, Vanport Media, in November
of 2026.

This repository holds hand-typed program listings from that book.

Where applicable, the individual programs describe their individual
licenses, in their introductory remarks.

See [RUNNING.md](RUNNING.md) for information on how I set up an environment
to test these listings. But it’s... pretty involved and somewhat technical,
and most users will likely prefer to adapt the programs to an environment
that has a different Microsoft BASIC implementation, one that’s easier to
find emulators for - such as an Apple //e, or a Commodore 64.

In particular, many of the programs use terminal escape sequences to do
things like clear the screen, move the cursor to a different position, or
provide color. You'll either need to adapt those to use more appropriate
techniques for your chosen emulator/BASIC implementation, or else emulate a
serial connection so that I/O goes through a terminal program.

The listings for each BASIC program are each in a dedicated directory.
All of them end in `.bas`, and are named according to the following
conventions:

  * `original.bas` - the original listings from the book (or as close as I can type them)
  * `tweaks.bas` - modified from the original to include changes I personally find more comfortable. If I find a bug, I fix it in this listing. "ENTER A NUMBER" prompts for seeding the PRNG are removed, as the `kb9` wrapper script automatically seeds the PRNG.
  * `apple2e` - ported to AppleSoft, intended to run on an Apple //e or later (80-column support via `PR#3`.

I tested the apple2e.bas files using my terminal-oriented emulator [bobbin](https://github.com/micahcowan/bobbin)—i.e. `bobbin --remain-tty < borg-attack/apple2e.bas`.
