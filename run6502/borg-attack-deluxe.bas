1 REM 'BORG ATTACK' BY DAVE HASSLER FOR 6502 TINY BASIC, OCT. 2022.
2 REM FIGLET FONT VERSION BY KENT NASSEN, AUG. 1994. ASCII ART FROM
3 REM HTTP://ASCIIART.EU, DESIGN BY DAVE HASSLER.
4 REM THIS VERSION FOR KIM-1 BASIC 9 v1.2 (C) BY DAVID HASSLER, MAY '26,
5 REM AND RELEASED UNDER THE MIT LICENSE.
8 GOSUB 2150:PRINT CL$;:GOSUB 3100
10 DK=1:DJ=0:GOSUB 300
20 GOSUB 1200:REM DRAW BORDER AND CHANDRA, POD DOCKED

29 REM M,N: SHIP COORDS. G,H: JUMP COORDS. B,C: BORG COORDS
30 D=2:E=100:G=0:H=0:M=0:N=0:T=2:Z=0
35 SP$="                                        "
40 PRINT HM$;"DOCKED AT CHANDRA V.":GOSUB2350
45 B=INT(RND(1)*9):C=INT(RND(1)*9)
50 IF B>6-LTHEN70
55 IF C>6-LTHEN70
60 GOTO45
70 GOTO200

100 R=RND(1)
110 IF R<.7THEN B=B-1
115 IF (L=1 OR LL=1) AND R<.2 THEN B=B-1
120 IF B<0 THEN B=0
130 R=RND(1)
140 IF R<.7THEN C=C-1
145 IF (L=1 OR LL=1) AND R<.2 THEN C=C-1
159 IF C<0 THEN C=0
160 IF B=0 AND C=0 THEN 1800
170 IF DJ=1 THEN 400

200 GOTO 1350:REM MOVE PLAYER

299 REM XXX MJC: IS THIS LOGIC RIGHT?
300 LL=0:PRINT CL$;"E N T E R   L E V E L":PRINT
310 PRINT" 1 SEASONED CAPTAIN":PRINT
315 PRINT" 2 HOTSHOT LIEUTENANT":PRINT
320 PRINT" 3 BRAND NEW ENSIGN":PRINT
330 GET L$:L=VAL(L$):IF L<1 OR L>3 THEN 330
340 L=L-1
350 IF L=1 THEN LL=1:L=0
355 IF L=2 THEN L=1
360 REM PRINT:PRINT "ENTER A NUMBER, UP TO 4 DIGIS"
365 REM INPUT R:IF R>9999 THEN 365
370 PRINT CL$;CF$:RETURN

400 GOSUB 2400:PRINT "JUMPING";:GOSUB 490
425 IF DJ=1 THEN 500
430 X=G:Y=H:GOSUB 1500:PRINTYL$;">";WH$:M=G:N=H
440 PRINT HM$;"JUMP COMPLETE.":FOR I=1TO1200:NEXT I
450 GOSUB 2400:PRINT"SCANNING";"GOSUB 490
460 GOTO 1100
490 FOR I=1TO5:FOR J=1TO150:NEXT J:PRINT".";:NEXT I:RETURN

500 X=G:Y=H:GOSUB1500:PRINT " "
505 DJ=0:DK=1:G=0:H=0:X=0:Y=0:GOSUB1500:PRINT CY$;"D";WH$
510 GOSUB 2400:PRINT "REPAIR/RE-ARM AT BASE";
520 GOSUB 490
530 T=2:E=100:GOSUB 2350
540 GOSUB 2400:PRINT "DONE. C-FIVE CLEAR.           "
550 GOSUB2350:GOTO100

700 GOSUB 2400:FOR K=1TO2:PRINT RD$;" * R E D  A L E R T *";WH$
702 GOSUB 2350:GOSUB 2400:GOSUB 2350:NEXT K
710 X=B:Y=C:GOSUB 1500:PRINT GR$;"#"
712 GOSUB 2400:PRINT "WE ARE THE BORG...   ":GOSUB 2350
720 GOSUB 2400:PRINT "RESISTANCE IS FUTILE.";WH$:GOSUB 2300

730 GOSUB 2400:PRINT "COMMAND (FIRE/JUMP TO BASE):"
740 PRINT BK$;:GET C$:PRINT WH$
745 IF C$="J" OR C$="j" THEN DJ=1:GOTO 100
750 IF C$="F" OR C$="f" THEN 770
760 GOTO 740
770 T=T-1
780 IF T<0 THEN GOSUB 2400:PRINT "** NO TORPEDOES! **"
790 IF T<0 THEN GOSUB 2350:GOTO 730
800 GOSUB 2400:PRINT "TORPEDO AWAY";:GOSUB 490
880 R=INT(RND(1)*100)
890 IF R<10-(L*5)THEN 1600
900 IF R<(50+LL*15)-(L*10)THEN 930
910 GOSUB 2400:PRINT "DEFLECTED!               ":GOSUB 2350
920 GOTO 950
930 D=D-1:IF D=0 THEN 1600
940 GOSUB 2400:PRINT "HIT: MODERATE DAMAGE.":GOSUB 2350

950 GOSUB 2400:PRINT "INCOMING";:GOSUB 490
955 R=INT(RND(1)*68)+33:E=E-R:E$=STR$(E)
960 IF E>0 THEN GOSUB 2400:PRINT "P O W !! SHIELDS:";E$;"%"
970 GOSUB 2350:IF E<=0 THEN 1700
980 GOTO 730

1100 IF G=B AND H=C THEN 700
1110 U=ABS(G-B):V=ABS(H-C)
1120 IF U>1 OR V>1 THEN 1180
1125 X=B:Y=C:GOSUB 1500:PRINT MA$;"?";WH$:A=B:Z=C:AF=1
1160 B$=MID$(STR$(B),2,1):C$=MID$(STR$(C),2,1)
1165 GOSUB 2400:PRINT "ANOMALY IN SECTOR ";B$;",";C$
1170 GOSUB 2300:GOSUB 1500:PRINT " ":GOTO 100
1180 GOSUB 2400:PRINT "ALL CLEAR.":GOSUB 2350:GOTO 100

1200 PRINT CL$;HM$;DN$
1210 PRINT"  ";:FOR I=0TO8:I$=STR$(I):PRINT I$;:NEXT I:PRINT
1220 FOR I=0TO8:PRINT I:NEXT I
1230 X=0:Y=0:GOSUB 1500:PRINT CY$;"D";WH$:RETURN

1299 REM POSITION CURSOR
1350 GOSUB 2400:PRINT "CURRENT SECTOR: ";
1355 G$=RIGHT$(STR$(G),1):H$=RIGHT$(STR$(H),1)
1360 PRINT G$;",";H$

1370 PRINT BK$;:GET J$:PRINT WH$
1380 IF AF=1 THEN AF=0:X=A:Y=Z:GOSUB 1500:PRINT " "
1402 IFJ$="J" OR J$="j" THEN 1415
1404 IFJ$="S" OR J$="s" THEN 1440:REM DOWN
1406 IFJ$="A" OR J$="a" THEN 1455:REM LEFT
1408 IFJ$="W" OR J$="w" THEN 1470:REM UP
1410 IFJ$="D" OR J$="d" THEN 1485:REM RT
1412 GOTO1350

1415 IF M=0 AND N=0THEN 1425
1417 X=M:Y=N:GOSUB 1500
1420 PRINT " "
1425 GOTO 400

1439 REM DOWN
1440 IF H=8 THEN 1370:REM BOUNDARY
1442 IF DK=1 THEN X=0:Y=0:M=0:N=0:GOSUB 1500:PRINT CY$;
1443 IF DK=1 THEN DK=0:PRINT"O";WH$:GOTO 1450
1445 X=G:Y=H:GOSUB 1500:IF G=M AND H=N THEN PRINT YL$;">";WH$:GOTO1450
1447 PRINT " "
1450 H=H+1:X=G:Y=H:GOSUB 1500:PRINT "+":GOTO 1350

1453 REM LEFT
1455 IF H=0 AND G=1 THEN 1370
1457 IF G=0 THEN 1370
1460 X=G:Y=H:GOSUB 1500:IF G=M AND H=N THEN PRINT YL$;">";WH$:GOTO1465
1462 PRINT " "
1465 G=G-1:X=G:Y=H:GOSUB 1500:PRINT "+":GOTO 1350

1469 REM UP
1470 IF H=0 THEN 1370
1472 IF G=0 AND H=1 THEN 1370
1475 X=G:Y=H:GOSUB 1500:IF G=M AND H=N THEN PRINT YL$;">";WH$:GOTO1480
1478 PRINT " "
1480 H=H-1:X=G:Y=H:GOSUB 1500:PRINT "+":GOTO 1350

1484 REM RIGHT
1485 IF G=8 THEN 1370
1487 IF DK=1 THEN X=0:Y=0:M=0:N=0:GOSUB 1500:PRINT CY$;
1488 IF DK=1 THEN DK=0:PRINT"O";WH$:GOTO 1495
1490 X=G:Y=H:GOSUB 1500:IF G=M AND H=N THEN PRINT YL$;">";WH$:GOTO1495
1492 PRINT " "
1495 G=G+1:X=G:Y=H:GOSUB 1500:PRINT "+":GOTO 1350

1500 PRINT HM$;DN$:?RT$;RT$;
1510 X1=X*2:FOR I=0TOX1:PRINT RT$;:NEXT I
1520 FOR I=0TOY:PRINT DN$;:NEXT I:RETURN

1600 GOSUB 2400:PRINT "GREAT SHOT!  CUBE DISABLED!":GOSUB 2300
1605 GOSUB 2400:PRINT "CHANDRA V IS SAVED!":GOSUB 2300
1607 X=B:Y=C:GOSUB 1500:PRINT " ";HM$;DN$
1650 GOTO 1900

1700 GOSUB 2400:PRINT MA$;"  ** B L A M - O! **":GOSUB 2300
1705 GOSUB 2400:PRINT "  SHUTTLE DISABLED.":GOSUB 2350
1710 GOSUB 2400:PRINT GR$;"YOU WILL BE ASSIMILATED.";WH$:GOSUB 2300

1800 X=B:Y=C:GOSUB 1500:PRINT " ":X=0:Y=0:GOSUB 1500:PRINT GR$;"#";WH$
1810 GOSUB 2400:PRINT "THE BORG REACHED CHANDRA V.":GOSUB 2350
1815 GOSUB 2400:PRINT "ALL WERE ASSIMILATED!":GOSUB 2300

1900 GOSUB 2400:PRINTHM$;"  PLAY AGAIN (Y/N)?";
1905 GET C$
1910 IF C$="Y" OR C$="y" THEN 8
1915 PRINT CL$;"THANKS FOR PLAYING."
1917 PRINT "SEE YOU AT TEN-FORWARD."
1930 PRINT CN$:END

2149 REM ANSI 'ESCAPE CODES' TO MANIPULATE CURSOR
2150 ES$=CHR$(27)+CHR$(91):HM$=ES$+"H":DN$=ES$+"B":RT$=ES$+"C"
2160 RD$=ES$+"31m":GR$=ES$+"32m":YL$=ES$+"1;33m":CY$=ES$+"36m"
2185 MA$=ES$+"35m":CF$=ES$+"?25l":N$=ES$+"?25h":REM CURSOR OFF/ON
2190 LF$=ES$+"D":UP$=ES$+"A":BK$=ES$+"30m":WH$=ES$+"37m"
2195 CL$=ES$+"H"+ES$+"J":RETURN

2300 FOR I=1TO1600:NEXT I:RETURN
2350 FOR I=1TO800:NEXT I:RETURN
2400 PRINT HM$;SP$;HM$;:RETURN

3100 PRINT CF$;
3120 PRINT "              ______.  _____   ______  _____"
3130 PRINT "              |_____] |     | |_____/ | ____        ."
3140 PRINT "  .           |_____] |_____| |    \_ |_____|"
3150 PRINT
3160 PRINT "      _______ _______ _______ _______ ______ _     _ "
3170 PRINT "      |_____|    |       |    |_____| |      |____/   /"
3180 PRINT " .    |     |    |       |    |     | |_____ |    \_ ."
3190 PRINT:PRINT
3200 PRINT GR$;"  ____+------+.                ";WH$;".";
3205 PRINT CY$;"         _____";GR$
3210 PRINT "      |`.    | `.     ";WH$;".";GR$;"               ";
3215 PRINT CY$;".-'|   |'-.  ";GR$
3220 PRINT "      |  `+--+---+                  ";
3225 PRINT CY$;".'   ||||||  '.";GR$
3230 PRINT "    __|   |  |   |                 ";
3235 PRINT CY$;"/   |||||||    .\";GR$
3240 PRINT "      +---+--+.  |                ";
3245 PRINT CY$;";     ||||      ||;";GR$
3250 PRINT "       `. |    `.|                ";
3255 PRINT CY$;"|   ||||||     ||||";GR$
3260 PRINT "     ____`+------+       ";WH$;".";
3265 PRINT CY$;"        ;||||||||    |||||;"
3270 PRINT "                                   \||        |||||/"
3280 PRINT "      ";YL$;"by Dave Hassler";
3285 PRINT CY$;"               '.         ||.'"
3290 PRINT "                                      '-. ___ .-'       ";
3292 PRINT WH$;"."
3295 PRINT "A-W-S-D to move jump crosshair"
3297 PRINT "   F to fire     J to jump"
3300 PRINT "Press I for instructions, any other key to start."
3310 GET A$:IF A$<>"I" AND A$<>"i" THEN RETURN

3400 PRINT CL$;"OUR STORY THUS FAR..."
3410 PRINT"  A cloaked Borg cube is bearing down on the Chandra"
3420 PRINT"system. The fifth planet is home to  brilliant and"
3430 PRINT"peaceful species that has mastered navigating the"
3440 PRINT"infinite 'mycelial network'. The Borg must not assimilate"
3450 PRINT"this closely-guarded knowledge, and the Chandrans cannot"
3460 PRINT"defend themselves. It is up to YOU to save them, and the"
3470 PRINT"galaxy.  Your shuttle is equipped with secret technology"
3480 PRINT"from Section 31, the 'black ops' arm of Starfleet. You"
3490 PRINT"have two multiphasic torpedoes and a shield system. The"
3500 PRINT"shuttle also possesses a limited mycelial 'jump drive.'"
3510 PRINT"  The Borg are clever. While the cloaked cube will move"
3520 PRINT"relentlessly toward the planet, it will sometimes feint:"
3530 PRINT"zig and zag, maybe hold position, all to deceive"
3540 PRINT"any possible pursuer...such as you. Your best chance to"
3550 PRINT"save the Chandrans is to find the cube early in your"
3560 PRINT"mission, so you have a small margin for error. But if you"
3570 PRINT"find it close to the planet...":PRINT
3580 ?:? YL$;"Press any key for the next screen. ";WH$:GET A$:PRINT

3590 PRINT CL$;"GAME PLAY"
3600 PRINT"  The quadrant is laid out on a 9x9 grid. The Borg cloaked"
3610 PRINT"cube will show up somewhere on the outer rim, and"
3020 PRINT"methodically work its way toward the planet at 0,0. Use"
3630 PRINT"the A-W-S-D keys to move the jump crosshair once the"
3635 PRINT"'CURRENT SECTOR' is displayed, and then press J to engage"
3640 PRINT"the jump engine. Sensors will tell you if an 'anomoly' is"
3650 PRINT"nearby, but that's all they can detect."
3660 PRINT"  One problem is that when you jump, the cube moves also,"
3670 PRINT"so you have to anticipate where it will go next. Unless"
3680 PRINT"you're very lucky, it will take two successful hits to"
3690 PRINT"disable the cube. Unfortunately, the Borg possess superior"
3700 PRINT"weapons. You have the option of returning to Chandra V to"
3710 PRINT"reload and repair, but remember: the cube will have moved"
3720 PRINT"*twice* if you must jump to the station, once when you go"
3730 PRINT"and again when you depart. If you wish to remain in your"
3740 PRINT"current sector, don't move the crosshair - just press J."
3750 ?:? YL$;"Press any key for the next screen. ";WH$:GET A$:PRINT

3760 PRINT CL$;"LEVELS"
3770 PRINT"  Captain (initial level) - the cube will appear somewhere"
3780 PRINT"in the outer part of the quadrant no more than two grids"
3790 PRINT"in. The chance of a perfect shot is 10%, and a solid hit"
3800 PRINT"50%. The cube will only move one grid (or none) at a time"
3810 PRINT"- vertically, horizontally, or diagonally - due to the"
3820 PRINT"captain's experience with the Borg."
3830 PRINT"  Lieutenant (middle level) - the cube will appear no more"
3840 PRINT"than two grids in from the edge, and the lieutenant has a"
3850 PRINT"65% chance of a hit, but the cube will move 0, 1, or 2"
3860 PRINT"grids at a time. This reflects the young pilot's reflexes"
3870 PRINT"and daring, but lack of experience."
3880 PRINT"  Ensign (toughest level) - fresh from the Academy, this"
3890 PRINT"officer will find the cube somewhere up to three grids in"
3900 PRINT"from the edge. The chance of a perfect shot is only 5%,"
3910 PRINT"and 40% of making any shot at all. Also, the cube will"
3920 PRINT"move 0, 1, or 2 grids at a time, reflecting the ensign's"
3930 PRINT"total lack of experience."
3940 PRINT:PRINT"GOOD LUCK, OFFICER! (...and Caps Lock ON!)":PRINT
3950 ? YL$;"Press any key to begin the game. ";WH$:GET A$:?:RETURN
