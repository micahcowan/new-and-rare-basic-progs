# Makefile to generate Apple II disk for
# Borg Attack Deluxe-with-sound
# 
# This makefile depends on bobbin, a shell-scriptable Apple II emulator,
# available at github.com/micahcowan/bobbin

borg-attack-deluxe/BORG.dsk: PLAY.dsk borg-attack-deluxe/apple2-snd.bas borg-attack-deluxe/apple2.bas Makefile
	rm -f "$@".tmp
	cp PLAY.dsk "$@".tmp
	{ echo NEW; cat borg-attack-deluxe/apple2-snd.bas; \
	  echo SAVE BORGSND.BAS; } | bobbin -m plus --disk "$@".tmp
	{ echo NEW; cat borg-attack-deluxe/apple2.bas; \
	  echo SAVE BORGMUTED.BAS; } | bobbin -m plus --disk "$@".tmp
	{ echo '100 ?"RESET AND TYPE '\''RUN BORGMUTED.BAS'\'\"; \
	  echo '110 ?"TO USE WITHOUT SOUND":?"'; \
	  echo '200 ?"CATALOG:":?CHR$$(4)"CATALOG"'; \
	  echo '300 ?:?"LOADING GAME...":?CHR$$(4)"RUN BORGSND.BAS"'; \
	  echo 'SAVE HELLO'; \
	  } | bobbin -m plus --disk "$@".tmp
	mv "$@".tmp "$@"
