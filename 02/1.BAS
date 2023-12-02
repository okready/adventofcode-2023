CONST MAXR = 12
CONST MAXG = 13
CONST MAXB = 14

sum& = 0
game% = 1

OPEN "INPUT" FOR INPUT ACCESS READ AS #1
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$
    ofs% = INSTR(ln$, ":") + 2
    isgood% = -1
    DO
        DO
            spofs% = INSTR(ofs% + 1, ln$, " ")

            endofs% = LEN(ln$) + 1
            sepofs% = INSTR(spofs% + 1, ln$, ",")
            IF sepofs% > 0 THEN
                endofs% = sepofs%
            END IF
            sepofs% = INSTR(spofs% + 1, ln$, ";")
            IF sepofs% > 0 AND sepofs% < endofs% THEN
                endofs% = sepofs%
            END IF

            num% = VAL(MID$(ln$, ofs%, spofs% - ofs%))
            spofs% = spofs% + 1
            color$ = MID$(ln$, spofs%, endofs% - spofs%)
            SELECT CASE color$
                CASE "red"
                    isgood% = num% <= MAXR
                CASE "green"
                    isgood% = num% <= MAXG
                CASE ELSE
                    isgood% = num% <= MAXB
            END SELECT

            ofs% = endofs% + 2
        LOOP WHILE isgood% AND ofs% <= LEN(ln$)
    LOOP WHILE isgood% AND ofs% <= LEN(ln$)

    IF isgood% THEN
        sum& = sum& + game%
    END IF

    game% = game% + 1
LOOP

PRINT sum&

