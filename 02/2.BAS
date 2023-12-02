sum& = 0

OPEN "INPUT" FOR INPUT ACCESS READ AS #1
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$
    ofs% = INSTR(ln$, ":") + 2
    r% = 0
    g% = 0
    b% = 0
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
                    IF num% > r% THEN
                        r% = num%
                    END IF
                CASE "green"
                    IF num% > g% THEN
                        g% = num%
                    END IF
                CASE ELSE
                    IF num% > b% THEN
                        b% = num%
                    END IF
            END SELECT

            ofs% = endofs% + 2
        LOOP WHILE ofs% <= LEN(ln$)
    LOOP WHILE ofs% <= LEN(ln$)

    sum& = sum& + r% * g% * b%
LOOP

PRINT sum&

