DECLARE FUNCTION EatNum% (ln$, idx%)

CONST WINCOUNT = 10
CONST CARDSIZE = 25

DIM wins%(WINCOUNT - 1)
DIM copies&(CARDSIZE - 1)

card% = 0
result& = 0

OPEN "INPUT" FOR INPUT ACCESS READ AS #1
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$

    cur% = INSTR(ln$, ":") + 2
    FOR i% = 0 TO WINCOUNT - 1
        wins%(i%) = EatNum%(ln$, cur%)
    NEXT
    cur% = INSTR(cur%, ln$, "|") + 2

    winct% = 0
    FOR i% = 0 TO CARDSIZE - 1
        num% = EatNum%(ln$, cur%)
        FOR j% = 0 TO WINCOUNT - 1
            IF num% = wins%(j%) THEN
                winct% = winct% + 1
                EXIT FOR
            END IF
        NEXT
    NEXT

    cur% = card% MOD CARDSIZE
    mult& = copies&(cur%) + 1
    copies&(cur%) = 0
    FOR i% = card% + 1 TO card% + winct%
        cur% = i% MOD CARDSIZE
        copies&(cur%) = copies&(cur%) + mult&
    NEXT

    result& = result& + mult&
    card% = card% + 1
LOOP
CLOSE #1

PRINT result&

FUNCTION EatNum% (ln$, idx%)
    start% = idx%
    DO WHILE MID$(ln$, start%, 1) = " "
        start% = start% + 1
    LOOP
    idx% = start%
    DO WHILE idx% <= LEN(ln$) AND MID$(ln$, idx%, 1) <> " "
        idx% = idx% + 1
    LOOP
    EatNum% = VAL(MID$(ln$, start%, idx% - start%))
END FUNCTION

