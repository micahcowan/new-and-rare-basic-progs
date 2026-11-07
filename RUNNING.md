# Notes on Porting KIM-1 to a general 6502 simulator

KIM-1 output routine is at $1EA0
KIM-1 char in routine is at $1E5A

I'm using the `run6502` command from
=> https://github.com/ShonFrazier/lib6502 ShonFrazier’s lib6502

Use the "kb9" wrapper script provided (invocation details below). It
automatically sends answers to the initial "MEMORY WIDTH?", "TERMINAL
WIDTH?", etc. questions, and sets up the terminal to disable things like
line buffering, and carriage-return translation into newline characters.

Invoke it like: `kb9 some-prog.bas`. Be sure that both kb9 and run6502 are
in your PATH, and that KB9.BIN (a binary image of KIM-1 BASIC 9) is in the
same dir as the kb9 script. See below for necessary modifications to the
stock KIM-1 BASIC 9 v1.1 binary.

## Fixing KIM-1 BASIC 9 v1.1

These fixes assume a stock, unmodified v1.1 binary image

### Shutting up the constant BREAKs

I'm not sure it's not a bad download of KIM-1 BASIC 9 v1.1, but when I tried to run commands like LIST or RUN, it aborts with BREAK. *Sigh*, I'm not done yet!

=> http://retro.hansotten.nl/uploads/files/kb9v11.zip This is the KB9 v1.1 I downloaded, in case it matters

=> http://retro.hansotten.nl/uploads/6502docs/kimkb9basic.pdf KIM-1 BASIC manual

Examining a smattering of code the KIM-1 BASIC manual mentions as being related to Control-C detection for triggering BREAKS, I see the following (in the Apple ][ Monitor's disassembler:)

```
26E3-   A9 03       LDA   #$03
26E5-   18          CLC   
26E6-   C9 03       CMP   #$03
26E8-   B0 01       BCS   $26EB
26EA-   18          CLC   
26EB-   D0 3D       BNE   $272A
```

...with the `LDA #$03` just preceding that `CMP #$03`, it seems like this will just always trigger? Hence why I wonder if I actually got a good download... anyway, I tried changing the `CMP #$03` to `CMP #$FF` with a `POKE 9959, 255` (or, edit the binary file at location $06E7 to set it to #$FF), and that fixed the problem. Of course, now nothing can trigger BREAK, but that hardly matters as a Control-C will cause run6502 to exit from a SIGTERM, so... *shrug*.

### Dave Hassler’s Tweaks

Keep in mind! If you’re modifying the image directly, instead of memory
locations after the image is loaded, then you must subtract ($2000) from the
locations given below (i.e., leave out the initial "2" in locations).

* Change the value of location $2AEE from $D0 to $F0 (POKE 10990,240), to enable the `GET` command
* Disable BREAK on empty INPUT lines by changing the value at $2AA8 to $A9 (POKE 10920, 169)
* Scan for backspace instead of underscore to delete chars—242C: 08 F0 F1; 243F: EA EA EA EA. Depending on your terminal, you may need to manually type Ctrl-H for backspaces (many terminals send DEL/Ctrl-? instead!)

### One Remaining Issue

The only remaining issue I have with this setup, is that run6502 doesn't
throttle its CPU speed to be anything near as slow as 6502s of the 70s and
80s. Therefore, attempts to pause in BASIC using a FOR loop (e.g., `FOR I=1
TO 500:NEXT I`) do not work.

# Getting KIM BASIC 9 v1.1 to run on Apple II

(*ignore this section*. unfinished/failed Apple II port, but these are the notes for how far I got)

bobbin invocation:
```
bobbin --simple --delay-pc INPUT  --load KB9.BIN --load-at '$2000'
```

Patched output in the monitor:
```
*2A52:5C DB
```

Patched input in the monitor:
```
300: 20 0C FD 29 7F 60
2457: 0 3
2AE6: 0 3
```

start BASIC with:
```
4065G
```

...works, but there's no local echo?
