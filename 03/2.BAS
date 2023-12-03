DECLARE FUNCTION Min% (x%, y%)
DECLARE FUNCTION Max% (x%, y%)
DECLARE FUNCTION IsDigit% (c$)
DECLARE SUB FinishNumParse (curnum$)
DECLARE SUB AddUnique (vals%(), count%, x%)
DECLARE SUB ScanNeighbors (x%, y%)

CONST FALSE = 0
CONST TRUE = NOT FALSE

CONST ENGINEWIDTH = 140
CONST ENGINEHEIGHT = 140

CONST MAXNUMBERS = 1500
CONST GEARID = -1
CONST OTHERID = -2

DIM SHARED engine%(ENGINEWIDTH - 1, ENGINEHEIGHT - 1)
DIM SHARED nums%(MAXNUMBERS - 1)
DIM SHARED numcount%
DIM SHARED result&

y% = 0
OPEN "INPUT" FOR INPUT ACCESS READ AS #1
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$
    FOR x% = 0 TO ENGINEWIDTH - 1
        c$ = MID$(ln$, x% + 1, 1)
        IF IsDigit%(c$) THEN
            curnum$ = curnum$ + c$
            engine%(x%, y%) = numcount%
        ELSE
            FinishNumParse curnum$
            IF c$ = "*" THEN
                engine%(x%, y%) = GEARID
            ELSE
                engine%(x%, y%) = OTHERID
            END IF
        END IF
    NEXT

    FinishNumParse curnum$
    y% = y% + 1
LOOP

numid% = -1
FOR y% = 0 TO ENGINEHEIGHT - 1
    FOR x% = 0 TO ENGINEWIDTH - 1
        IF engine%(x%, y%) = GEARID THEN
            ScanNeighbors x%, y%
        END IF
    NEXT
NEXT

PRINT result&

SUB AddUnique (vals%(), count%, x%)
    FOR i% = 0 TO count% - 1
        IF vals%(i%) = x% THEN
            EXIT SUB
        END IF
    NEXT

    vals%(count%) = x%
    count% = count% + 1
END SUB

SUB FinishNumParse (curnum$)
    IF LEN(curnum$) <> 0 THEN
        nums%(numcount%) = VAL(curnum$)
        numcount% = numcount% + 1
        curnum$ = ""
    END IF
END SUB

FUNCTION IsDigit% (c$)
    CONST ASC0 = 48
    CONST ASC9 = 57

    casc% = ASC(c$)
    IsDigit% = casc% >= ASC0 AND casc% <= ASC9
END FUNCTION

FUNCTION Max% (x%, y%)
    IF x% >= y% THEN
        Max% = x%
    ELSE
        Max% = y%
    END IF
END FUNCTION

FUNCTION Min% (x%, y%)
    IF x% <= y% THEN
        Min% = x%
    ELSE
        Min% = y%
    END IF
END FUNCTION

SUB ScanNeighbors (x%, y%)
    DIM adjnums%(7)

    adjnumcount% = 0
    xlo% = Max%(x% - 1, 0)
    xhi% = Min%(x% + 1, ENGINEWIDTH - 1)
    ylo% = Max%(y% - 1, 0)
    yhi% = Min%(y% + 1, ENGINEHEIGHT - 1)
    FOR sy% = ylo% TO yhi%
        FOR sx% = xlo% TO xhi%
            IF sx% <> x% OR sy% <> y% THEN
                id% = engine%(sx%, sy%)
                IF id% >= 0 THEN
                    AddUnique adjnums%(), adjnumcount%, id%
                    IF adjnumcount% > 2 THEN
                        EXIT SUB
                    END IF
                END IF
            END IF
        NEXT
    NEXT

    IF adjnumcount% = 2 THEN
        adj0& = nums%(adjnums%(0))
        adj1& = nums%(adjnums%(1))
        result& = result& + adj0& * adj1&
    END IF
END SUB

