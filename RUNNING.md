# Notes on Porting KIM-1 to a general 6502 simulator

KIM-1 output routine is at $1EA0
KIM-1 char in routine is at $1E5A

I'm using the `run6502` command from
=> https://github.com/ShonFrazier/lib6502 ShonFrazier’s lib6502

The command to run the simulation is
```
run6502 -l KB9.BIN -l 1E5A wrap.bin -G 300 -P 1EA0 -R 4065
```

(KB9.BIN should be unmodified v1.1)

### run6502 invocation explanation

(options explained out-of-order:)

```
-l 2000 ~/dl/kb9v1/KB9.BIN ... -R 2000
```
KB9.BIN (v1.1) is designed to be loaded in at $2000, and starts from $4065. Fair enough.

```
-P 1EA0
```
Jumps to $1EA0 should be treated as PUTCHAR.

```
-l 1E5A wrap.bin -G 300
```
KB9 treats $1E5A as GETCHAR (and uses buffered I/O from C's getchar(3)). Originally, I just had `-G 1E5A`... but this doesn't work, as for line endings getchar(3) was returning a linefeed, whereas KIM BASIC expects a carriage return. I tried using `stty -icrnl` to direct the terminal emulation not to translate CRs on input into linefeeds... but that didn't work, because then the carriage returns were not detected as ending the buffer line to be sent to the emulator.

To resolve this issue, I wrote a small wrapper routine to translate newlines into carriage returns on input, *within* the emulator, before passing along to BASIC. Since KIM BASIC expects to call $1E5A for every character fetch, we need the wrapper to live *there*, and have the actual getchar(3) hook live somewhere else. I wrote the wrapper to call to $300 for the actual getchar(3) call, and so we got -G 300 instead of -G 1E5A.

### the char-input wrapper routine

The following machine code, poked in at $300, did the trick for me:
```
20 00 03 08 c9 0a d0 02  a9 0d 28 60
```

ca65 source code:
```
.org $1E5A

CIN=$300

jsr CIN
php
    cmp #$0A
    bne @a
    lda #$0D
@a:
plp
rts
```

commands used to build it:
```
ca65 wrap.asm65
ld65 -t none -o wrap.bin wrap.o
```

### Shutting up the constant BREAKs

I'm not sure it's not a bad download of KIM-1 BASIC 9 v1.1, but when I try to run commands like LIST or RUN, it aborts with BREAK. *Sigh*, I'm not done yet!

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

### Final Tweaks

...and with that BREAK tweak, we’re up and running. Programs can be entered, we can list them, and they run fine.

But we're not _quite_ done: since we used v1.1 (and I don't know the correct location to modify above for v1.2, which seems to change a number of locations around), we need to make the modifications described in the “New and Rare BASIC Programs”:

* Change the value of location $2AEE from $D0 to $F0 (POKE 10990,240), to enable the `GET` command
* Disable BREAK on empty INPUT lines by changing the value at $2AA8 to $A9 (POKE 10920, 169)
* Scan for backspace instead of underscore to delete chars—242C: 08 F0 F1; 243F: EA EA EA EA

Note that, since we're using buffered IO, GET will actually wait until a newline is pressed... and then the rest of that line past the first character is automatically fed to the next GET or INPUT. You could probably set raw/unbuffered mode with stty (which, in combination with disabling the CR -> LF (icrnl) translation, might also eliminate the need for the $300 hack I wrote)... but honestly I'll probably just add an INPUT statement after every GET (or just use INPUT instead, I guess)

### Wrapping it Up

Finally, I use the following wrapper script (which I’ve named `kb9`), to automate setting memory limits, terminal width, math-library selection, and PRNG seeding. Invoke it like: `kb9 some-prog.bas`.

```
#!/usr/bin/env bash

main() {
    { cat header.bas; seed; stdbuf -i0 -o0 cat "$@" /dev/stdin; } \
        | stdbuf -i0 -o0 ./run6502 \
            -R 4065 \
            -l 2000 KB9.BIN \
            -P 1EA0 \
            -l 1E5A wrap.bin -G 300
}

seed() {
    # Enter instructions to seed the random number generator
    echo "R = RND(-$((RANDOM % 32767)))"
    echo "NEW"
    echo "? \"START\""
}

main "$@"
exit 0
```

# Getting KIM BASIC 9 v1.1 to run on Apple II

(unfinished/failed, but these are the notes for how far I got)

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

