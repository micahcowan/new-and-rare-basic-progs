1 REM (C) 2022 DAVID HASSLER. RELEASED UNER MIT LICENSE.
15 GOSUB 1950
17 REM COMMENTED NExT TWO LINES OUT: ALREADY SEEDED PRNG
20 REM INPUT A
25 REM R=RND(-A)
27 D=2:E=100
30 G=0:H=0:T=2

35 PRINT"Docked at Chandra V Station (0,0)"
40 B=INT(RND(1)*6)+2:C=INT(RND(1)*6)+2
45 IF B>5 OR C>5 THEN 200
50 GOTO 40

99 REM MOVE CUBE
100 R=RND(1)
110 IF R<.75 THEN B=B-1
120 IF B<0 THEN B=0
130 R=RND(1)
135 IF R<.75 THEN C=C-1
150 IF C<0 THEN C=0
160 IF B=0 AND C=0 THEN 1800

200 PRINT
210 PRINT"Jump sector (X,Y)"
220 INPUT X,Y
230 IF X<0 OR X>7 THEN 310
250 IF Y<0 OR Y>7 THEN 310
270 G=X:H=Y
300 GOTO 400
310 PRINT"Error: not in quadrant.":GOTO 210
400 GOSUB 1000
405 PRINT"Jump complete."
410 IF G=0 AND H=0 THEN 500
415 PRINT"Scanning";
420 GOTO 1100

500 PRINT"Msg:"
510 PRINT" 'Chandra base, resupplying.'"
520 GOSUB 1000
530 T=2:E=100
540 PRINT" 'Done. C-Five clear."
550 GOTO 100

800 PRINT
810 PRINT"*** RED ALERT ***"
815 PRINT"Msg:"
820 PRINT" 'We are the BORG. Resistance is futile.'"
840 PRINT
850 PRINT"Cmd: (0-Attack, 1-Jump) ";
860 INPUT A
870 IF A>1 THEN 850
871 IF A=1 THEN 100
872 T=T-1
873 IF T<0 THEN PRINT"No torpedoes.":GOTO 850
875 PRINT"Torpedo away."
877 GOSUB 1000

880 R=RND(1)
890 IF R<.1 THEN 1600
900 IF R<.6 THEN 930
910 PRINT"Deflected!"
920 GOTO 970
930 D=D-1:IF D=0 THEN 1000
935 PRINT"Hit, moderate damage."
970 PRINT"Incoming..."
972 E=E-(INT(RND(1)*68)+33)
974 IF E>0 THEN PRINT"Pow! Shields:";E;"percent."
975 IF E<0 THEN 1700
976 GOTO 850

1000 FOR J=0TO4:FOR I=1TO300:NEXT I
1040 PRINT".";:NEXT J:?
1070 RETURN

1100 GOSUB 1000

1103 IF G=B AND H=C THEN 800
1105 U=G-B
1110 IF U<0 THEN U=B-G
1120 IF U>1 THEN 1180
1130 V=H-C
1140 IF V<0 THEN V=C-H
1150 IF V>1 THEN 1180
1165 PRINT"Anomoly found, sector ";B;",";C
1170 GOTO 1400
1180 PRINT"All clear."
1400 PRINT
1420 GOTO 100

1600 PRINT"A HIT! The Borg Cube is destroyed!":GOTO 1900
1700 PRINT"BLAM-O! Your shuttle is destroyed! R.I.P.":GOTO 1900
1800 PRINT"NO! The Borg got to Chandra V! All were assimilated."

1900 PRINT
1910 PRINT"Play again (Y/N)? ";
1920 INPUT A$:PRINT
1930 IF A$="Y" OR A$="y" THEN 27
1940 PRINT"Live long and prosper."
1949 END

1950 PRINT:PRINT
1960 PRINT"     _____________"
1965 PRINT"    /     .---.  (\    STAR TREK:"
1970 PRINT"   /      | O | (  \   Borg Attack"
1975 PRINT"  /ncc-   |   | |   \"
1980 PRINT"  \1701/4 |___|  ^^^/"
1985 PRINT"  _\_______________/   by Dave Hassler"
1990 PRINT" <_______________)"
1995 PRINT
2000 PRINT"Your shuttle has 'multiphasic' shields and torpedoes and"
2010 PRINT"a mycelial 'jump drive.' Your mission: stop the Borg from"
2020 PRINT"attacking Chandra V (at 0,0). The Cube warped in to the"
2040 PRINT"outer part of the 8x8 quadrant. You have two torpedoes;"
2050 PRINT"you can reload weapons and fix shields on Chandra Base,"
2060 PRINT"but it will cost precious time. Good luck."
2070 RETURN
