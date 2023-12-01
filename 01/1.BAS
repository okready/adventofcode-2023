OPEN "INPUT" FOR INPUT ACCESS READ AS #1

sum& = 0
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$

    FOR i% = 1 TO LEN(ln$)
        c% = ASC(MID$(ln$, i%, 1))
        IF c% >= ASC("0") AND c% <= ASC("9") THEN
            v% = (c% - ASC("0")) * 10
            EXIT FOR
        END IF
    NEXT

    FOR i% = LEN(ln$) TO 1 STEP -1
        c% = ASC(MID$(ln$, i%, 1))
        IF c% >= ASC("0") AND c% <= ASC("9") THEN
            v% = v% + c% - ASC("0")
            EXIT FOR
        END IF
    NEXT

    sum& = sum& + v%
LOOP

PRINT sum&

