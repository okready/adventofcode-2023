DECLARE FUNCTION GetValueAt% (ln$, i%)

DIM SHARED Words$(1 TO 9)
Words$(1) = "one"
Words$(2) = "two"
Words$(3) = "three"
Words$(4) = "four"
Words$(5) = "five"
Words$(6) = "six"
Words$(7) = "seven"
Words$(8) = "eight"
Words$(9) = "nine"

OPEN "INPUT" FOR INPUT ACCESS READ AS #1

sum& = 0
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$

    FOR i% = 1 TO LEN(ln$)
        c% = GetValueAt%(ln$, i%)
        IF c% >= 0 THEN
            v% = c% * 10
            EXIT FOR
        END IF
    NEXT

    FOR i% = LEN(ln$) TO 1 STEP -1
        c% = GetValueAt%(ln$, i%)
        IF c% >= 0 THEN
            v% = v% + c%
            EXIT FOR
        END IF
    NEXT

    sum& = sum& + v%
LOOP

PRINT sum&

FUNCTION GetValueAt% (ln$, i%)
    c% = ASC(MID$(ln$, i%, 1))
    IF c% >= ASC("0") AND c% <= ASC("9") THEN
        GetValueAt% = c% - ASC("0")
        EXIT FUNCTION
    END IF

    FOR j% = 1 TO 9
        w$ = Words$(j%)
        IF MID$(ln$, i%, LEN(w$)) = w$ THEN
            GetValueAt% = j%
            EXIT FUNCTION
        END IF
    NEXT

    GetValueAt% = -1
END FUNCTION

